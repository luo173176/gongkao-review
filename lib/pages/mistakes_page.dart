import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

final _searchProvider = StateProvider<String>((ref) => '');
final _moduleFilterProvider = StateProvider<String?>((ref) => null);
final _reasonFilterProvider = StateProvider<String?>((ref) => null);

class MistakesPage extends ConsumerWidget {
  const MistakesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mistakes =
        ref.watch(mistakesProvider).valueOrNull ?? const <Mistake>[];
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final query = ref.watch(_searchProvider);
    final moduleFilter = ref.watch(_moduleFilterProvider);
    final reasonFilter = ref.watch(_reasonFilterProvider);

    final examNames = {for (final e in exams) e.id: e.name};
    final q = query.trim().toLowerCase();
    final filtered = mistakes.where((m) {
      if (moduleFilter != null && m.module != moduleFilter) return false;
      if (reasonFilter != null && m.wrongReason != reasonFilter) return false;
      if (q.isNotEmpty) {
        final hit = m.knowledgePoint.toLowerCase().contains(q) ||
            m.question.toLowerCase().contains(q) ||
            m.tags.toLowerCase().contains(q);
        if (!hit) return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('错题本')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/mistakes/new'),
        icon: const Icon(Icons.add),
        label: const Text('记错题'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              onChanged: (v) => ref.read(_searchProvider.notifier).state = v,
              decoration: const InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: '搜索知识点 / 题目摘要 / 标签',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _chipRow(
            children: [
              _chip(context, ref, '全部模块', moduleFilter == null,
                  () => ref.read(_moduleFilterProvider.notifier).state = null),
              for (final m in xingceModules)
                _chip(context, ref, m, moduleFilter == m,
                    () => ref.read(_moduleFilterProvider.notifier).state = m),
            ],
          ),
          _chipRow(
            children: [
              _chip(context, ref, '全部错因', reasonFilter == null,
                  () => ref.read(_reasonFilterProvider.notifier).state = null),
              for (final r in wrongReasons)
                _chip(context, ref, r, reasonFilter == r,
                    () => ref.read(_reasonFilterProvider.notifier).state = r),
            ],
          ),
          Expanded(
            child: filtered.isEmpty
                ? const EmptyHint('没有匹配的错题。\n录入错题并标注错因，复盘会更有针对性。')
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final m = filtered[i];
                      final examName = m.examId == null
                          ? null
                          : examNames[m.examId!];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                            m.knowledgePoint.isEmpty
                                ? (m.question.isEmpty ? '未命名错题' : m.question)
                                : m.knowledgePoint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (m.question.isNotEmpty &&
                                  m.knowledgePoint.isNotEmpty)
                                Text(m.question,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  _tag(context, m.module.isEmpty ? '未分类' : m.module),
                                  _tag(context, m.wrongReason,
                                      highlight: true),
                                  if (examName != null) _tag(context, examName),
                                  ...m.tags
                                      .split(',')
                                      .map((t) => t.trim())
                                      .where((t) => t.isNotEmpty)
                                      .map((t) => _tag(context, '#$t')),
                                ],
                              ),
                            ],
                          ),
                          onTap: () => context.push('/mistakes/${m.id}/edit'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chipRow({required List<Widget> children}) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        children: children,
      ),
    );
  }

  Widget _chip(BuildContext context, WidgetRef ref, String label,
      bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        visualDensity: VisualDensity.compact,
        onSelected: (_) => onTap(),
      ),
    );
  }

  Widget _tag(BuildContext context, String text, {bool highlight = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: highlight
            ? scheme.primary.withAlpha(26)
            : scheme.surfaceContainerHighest.withAlpha(90),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 11,
            color: highlight ? scheme.primary : scheme.onSurfaceVariant),
      ),
    );
  }
}
