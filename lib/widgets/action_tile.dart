import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import 'common.dart';

/// 行动项列表瓦片：完成勾选 + 优先级/截止日期标签。
/// 首页与行动项页共用。
class ActionTile extends ConsumerWidget {
  const ActionTile({super.key, required this.item, this.showExamName = false});

  final ActionItem item;
  final bool showExamName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final done = item.status == '完成';
    final overdue = isOverdue(item, DateTime.now());

    Color priorityColor() => switch (item.priority) {
          '高' => scheme.error,
          '中' => Colors.orange,
          _ => scheme.primary,
        };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: done,
          onChanged: (_) async {
            final db = ref.read(dbProvider);
            await (db.update(db.actionItems)..where((a) => a.id.equals(item.id)))
                .write(ActionItemsCompanion(
              status: Value(done ? '待办' : '完成'),
              completedAt: Value(done ? null : DateTime.now()),
            ));
          },
        ),
        title: Text(
          item.title,
          style: done
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: scheme.onSurfaceVariant)
              : null,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _miniChip(context, item.priority, priorityColor(), outlined: true),
              if (item.dueDate != null)
                Text(
                  '${overdue ? '已逾期 ' : '截止 '}${fmtDate(item.dueDate!)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: overdue ? scheme.error : scheme.onSurfaceVariant,
                  ),
                ),
              Text('· ${item.owner}',
                  style: TextStyle(
                      fontSize: 12, color: scheme.onSurfaceVariant)),
              if (showExamName && item.relatedExamId != null)
                Consumer(builder: (context, ref, _) {
                  final exam = ref
                      .watch(examByIdProvider(item.relatedExamId!))
                      .valueOrNull;
                  if (exam == null) return const SizedBox.shrink();
                  return Text('· ${exam.name}',
                      style: TextStyle(
                          fontSize: 12, color: scheme.onSurfaceVariant));
                }),
            ],
          ),
        ),
        onTap: () => context.push('/actions/${item.id}/edit'),
      ),
    );
  }

  Widget _miniChip(BuildContext context, String label, Color color,
      {bool outlined = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
        color: outlined ? Colors.transparent : color.withAlpha(30),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 11, color: color)),
    );
  }
}
