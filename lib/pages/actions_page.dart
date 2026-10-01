import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../widgets/action_tile.dart';
import '../widgets/common.dart';

final _filterProvider = StateProvider<int>((ref) => 1);

class ActionsPage extends ConsumerWidget {
  const ActionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions =
        ref.watch(actionItemsProvider).valueOrNull ?? const <ActionItem>[];
    final filter = ref.watch(_filterProvider);

    final open = actions.where((a) => a.status != '完成').toList();
    final doing = open.where((a) => a.status == '进行中').toList();
    final todo = open.where((a) => a.status == '待办').toList();
    final done = actions.where((a) => a.status == '完成').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('行动项')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/actions/new'),
        icon: const Icon(Icons.add),
        label: const Text('新增'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('未完成')),
                ButtonSegment(value: 2, label: Text('已完成')),
                ButtonSegment(value: 0, label: Text('全部')),
              ],
              selected: {filter},
              onSelectionChanged: (s) =>
                  ref.read(_filterProvider.notifier).state = s.first,
            ),
          ),
          Expanded(
            child: switch (filter) {
              1 => _grouped(context, [
                    if (doing.isNotEmpty) ('进行中', doing),
                    if (todo.isNotEmpty) ('待办', todo),
                  ], emptyText: '没有未完成的行动项 🎉'),
              2 => _list(context, done),
              _ => _list(context, actions),
            },
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, List<ActionItem> items) {
    if (items.isEmpty) return const EmptyHint('还没有行动项。\n从复盘报告的「行动」一栏可以一键生成。');
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 88),
      itemCount: items.length,
      itemBuilder: (context, i) =>
          ActionTile(item: items[i], showExamName: true),
    );
  }

  Widget _grouped(
    BuildContext context,
    List<(String, List<ActionItem>)> groups, {
    required String emptyText,
  }) {
    final visible = groups.where((g) => g.$2.isNotEmpty).toList();
    if (visible.isEmpty) return EmptyHint(emptyText);
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 88),
      children: [
        for (final (label, items) in visible) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
            child: Text(label,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          ...items.map((a) => ActionTile(item: a, showExamName: true)),
        ],
      ],
    );
  }
}
