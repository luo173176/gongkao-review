import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import '../widgets/common.dart';

class ExamDetailPage extends ConsumerWidget {
  const ExamDetailPage({super.key, required this.examId});

  final int examId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(examByIdProvider(examId)).valueOrNull;
    final sections =
        ref.watch(sectionsProvider(examId)).valueOrNull ?? const <Section>[];
    final essays =
        ref.watch(essaysProvider(examId)).valueOrNull ?? const <EssayRecord>[];
    final mistakes =
        ref.watch(mistakesOfExamProvider(examId)).valueOrNull ??
            const <Mistake>[];
    final reviews =
        ref.watch(reviewsOfExamProvider(examId)).valueOrNull ??
            const <Review>[];

    if (exam == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyHint('套卷不存在或已被删除'),
      );
    }

    final orderedSections = () {
      final list = [...sections];
      list.sort((a, b) => xingceModules
          .indexOf(a.module)
          .compareTo(xingceModules.indexOf(b.module)));
      return list;
    }();
    final acc = overallAccuracy(sections);
    final review = reviews.isEmpty ? null : reviews.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.name),
        actions: [
          IconButton(
            tooltip: '编辑',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/exams/$examId/edit'),
          ),
          IconButton(
            tooltip: '删除',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final ok = await confirmDialog(
                context,
                content: '将删除「${exam.name}」及其模块、错题、复盘、关联行动项，不可恢复。',
              );
              if (!ok || !context.mounted) return;
              await ref.read(dbProvider).deleteExamCascade(examId);
              ref.invalidate(examByIdProvider(examId));
              if (context.mounted) context.pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Chip(
                        label: Text(exam.type),
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(fmtDate(exam.date),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('· ${exam.durationMinutes} 分钟',
                          style: Theme.of(context).textTheme.bodyMedium),
                      if (exam.totalScore != null)
                        Text('· 总分 ${exam.totalScore}',
                            style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  if (exam.note.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(exam.note, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: sections.isEmpty
                  ? Text('还没录入行测模块数据，点右上角编辑补充。',
                      style: Theme.of(context).textTheme.bodySmall)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('行测总体正确率',
                                style: Theme.of(context).textTheme.titleMedium),
                            const Spacer(),
                            Text(
                              fmtRate(acc),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        for (final s in orderedSections)
                          ModuleRateRow(
                            module: s.module,
                            correct: s.correctQuestions,
                            total: s.totalQuestions,
                            minutes: s.timeSpentMinutes,
                            targetRate: s.targetRate,
                          ),
                      ],
                    ),
            ),
          ),
          if (essays.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('申论', style: Theme.of(context).textTheme.titleMedium),
                    for (final e in essays)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(e.questionType),
                        subtitle: Text([
                          if (e.score != null) '得分 ${e.score}',
                          if (e.timeSpentMinutes > 0)
                            '${e.timeSpentMinutes} 分钟',
                        ].join(' · ')),
                        isThreeLine: false,
                        trailing: const Icon(Icons.chevron_right, size: 18),
                        onTap: () => _showEssaySheet(context, e),
                      ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('错题（${mistakes.length}）',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () =>
                          context.push('/mistakes/new?examId=$examId'),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('记错题'),
                    ),
                  ]),
                  if (mistakes.isEmpty)
                    Text('本次套卷还没有错题记录。',
                        style: Theme.of(context).textTheme.bodySmall),
                  for (final m in mistakes.take(10))
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        m.knowledgePoint.isEmpty ? m.question : m.knowledgePoint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                          '${m.module.isEmpty ? '未分类' : m.module} · ${m.wrongReason}',
                          style: const TextStyle(fontSize: 12)),
                      onTap: () => context.push('/mistakes/${m.id}/edit'),
                    ),
                  if (mistakes.length > 10)
                    Text('…共 ${mistakes.length} 条，去错题本查看全部',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('复盘报告', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    if (review != null)
                      TextButton(
                          onPressed: () => context.push('/exams/$examId/review'),
                          child: const Text('编辑')),
                  ]),
                  if (review == null) ...[
                    Text('用 KPT/PDCA 模板沉淀结论，并生成行动项。',
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () => context.push('/exams/$examId/review'),
                      icon: const Icon(Icons.description_outlined),
                      label: const Text('生成复盘报告'),
                    ),
                  ] else ...[
                    _reviewField(context, '保持', review.keep),
                    _reviewField(context, '问题', review.problem),
                    _reviewField(context, '尝试', review.attempt),
                    _reviewField(context, '行动', review.action),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _reviewField(BuildContext context, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13)),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void _showEssaySheet(BuildContext context, EssayRecord e) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.questionType, style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (e.score != null) Text('得分：${e.score}'),
              if (e.timeSpentMinutes > 0) Text('用时：${e.timeSpentMinutes} 分钟'),
              if (e.problem.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('问题', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(e.problem),
              ],
              if (e.improvement.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('改进点', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(e.improvement),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
