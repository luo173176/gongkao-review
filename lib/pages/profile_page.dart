import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final actions =
        ref.watch(actionItemsProvider).valueOrNull ?? const <ActionItem>[];
    final cards = ref.watch(cardsProvider).valueOrNull ?? const <KnowledgeCard>[];
    final mistakes =
        ref.watch(mistakesProvider).valueOrNull ?? const <Mistake>[];
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];

    final openCount = actions.where((a) => a.status != '完成').length;
    final daysLeft = settings.examDate == null
        ? null
        : dateOnly(settings.examDate!)
            .difference(dateOnly(DateTime.now()))
            .inDays;

    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Text(
                      settings.owner.isEmpty ? '我' : settings.owner.substring(0, 1),
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(settings.owner,
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          settings.examDate == null
                              ? '考试日期未设置'
                              : '距考试 ${daysLeft! < 0 ? '已过 ${-daysLeft} 天' : '还有 $daysLeft 天'}'
                                  '${settings.targetScore == null ? '' : ' · 目标 ${settings.targetScore} 分'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: '设置',
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () => context.push('/settings'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                _tile(context, Icons.assignment_outlined, '行动项',
                    '$openCount 项未完成', () => context.push('/actions')),
                const Divider(height: 1, indent: 16),
                _tile(context, Icons.style_outlined, '知识卡片',
                    '${cards.length} 张', () => context.push('/cards')),
                const Divider(height: 1, indent: 16),
                _tile(context, Icons.rule_outlined, '错题本',
                    '${mistakes.length} 条', () => context.push('/mistakes')),
                const Divider(height: 1, indent: 16),
                _tile(context, Icons.description_outlined, '套卷记录',
                    '${exams.length} 份', () => context.push('/exams')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                _tile(context, Icons.settings_outlined, '设置',
                    '考试日期、目标分数、备份', () => context.push('/settings')),
                const Divider(height: 1, indent: 16),
                _tile(context, Icons.info_outline, '关于', 'v0.1.0', () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('考公复盘'),
                      content: const Text(
                          '公务员考试套卷复盘工具 v0.1.0\n\n'
                          '记录套卷 → 录入模块正确率 → 标记错题与错因 → '
                          '生成复盘结论 → 创建行动项 → 追踪趋势。\n\n'
                          '数据仅保存在本机（SQLite），支持导出 JSON/CSV 备份。'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('好的')),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title,
      String trailing, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(trailing,
          style: Theme.of(context).textTheme.bodySmall),
      onTap: onTap,
    );
  }
}
