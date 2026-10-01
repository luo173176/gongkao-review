import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import '../widgets/action_tile.dart';
import '../widgets/common.dart';
import '../widgets/countdown_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final actions =
        ref.watch(actionItemsProvider).valueOrNull ?? const <ActionItem>[];
    final allSections =
        ref.watch(allSectionsProvider).valueOrNull ?? const <Section>[];
    final mistakes =
        ref.watch(mistakesProvider).valueOrNull ?? const <Mistake>[];

    final now = DateTime.now();
    final today = dateOnly(now);
    final dueTodayOrOverdue = actions
        .where((a) =>
            a.status != '完成' &&
            a.dueDate != null &&
            !dateOnly(a.dueDate!).isAfter(today))
        .toList();
    final openActions =
        actions.where((a) => a.status != '完成').toList();

    final lastExam = exams.isEmpty ? null : exams.first;
    final lastSections = lastExam == null
        ? const <Section>[]
        : allSections.where((s) => s.examId == lastExam.id).toList();
    final lastAcc = overallAccuracy(lastSections);

    final reasons = reasonDistribution(mistakes);
    final topReason = reasons.isEmpty
        ? null
        : (reasons.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .first;

    return Scaffold(
      appBar: AppBar(title: const Text('考公复盘')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CountdownCard(
            examDate: settings.examDate,
            onTap: () => context.push('/settings'),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
                child: StatCard(
                    title: '最近正确率',
                    value: lastAcc == null ? '--' : fmtRate(lastAcc))),
            const SizedBox(width: 8),
            Expanded(
                child: StatCard(
                    title: '待办行动项', value: '${openActions.length}')),
            const SizedBox(width: 8),
            Expanded(
                child:
                    StatCard(title: '错题累计', value: '${mistakes.length}')),
          ]),
          const SizedBox(height: 24),
          Row(children: [
            Text('今日待办', style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            TextButton(
                onPressed: () => context.push('/actions'),
                child: const Text('全部行动项')),
          ]),
          if (dueTodayOrOverdue.isEmpty)
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('今天没有到期的行动项 👍 放心刷题去。'))),
          ...dueTodayOrOverdue.take(3).map((a) => ActionTile(item: a)),
          if (lastExam != null) ...[
            const SizedBox(height: 16),
            Text('最近一次套卷', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                title: Text(lastExam.name),
                subtitle: Text(
                    '${lastExam.type} · ${fmtDate(lastExam.date)} · ${lastExam.durationMinutes} 分钟'),
                trailing: Text(
                  fmtRate(lastAcc),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () => context.push('/exams/${lastExam.id}'),
              ),
            ),
          ],
          const SizedBox(height: 16),
          _MiniTrendCard(allSections: allSections, exams: exams),
          const SizedBox(height: 16),
          if (topReason != null)
            Text('最常见的错因：${topReason.key}（${topReason.value} 次）',
                style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: () => context.push('/exams/new'),
                icon: const Icon(Icons.add),
                label: const Text('新增套卷'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => context.push('/mistakes/new'),
                icon: const Icon(Icons.rule),
                label: const Text('记错题'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => context.push('/cards/new'),
                icon: const Icon(Icons.style),
                label: const Text('记卡片'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniTrendCard extends StatelessWidget {
  const _MiniTrendCard({required this.allSections, required this.exams});

  final List<Section> allSections;
  final List<ExamRecord> exams;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pts = trend(exams, allSections);
    final recent =
        pts.length <= 5 ? pts : pts.sublist(pts.length - 5);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('最近正确率趋势',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (recent.length < 2)
              Text('记录 2 张以上套卷后显示趋势',
                  style: TextStyle(color: scheme.onSurfaceVariant))
            else
              SizedBox(
                height: 120,
                child: LineChart(LineChartData(
                  minX: 0,
                  maxX: (recent.length - 1).toDouble(),
                  minY: 0,
                  maxY: 100,
                  gridData: const FlGridData(
                          show: true, drawVerticalLine: false, horizontalInterval: 25),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  lineTouchData: const LineTouchData(enabled: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (var i = 0; i < recent.length; i++)
                          FlSpot(i.toDouble(), recent[i].rate * 100),
                      ],
                      isCurved: true,
                      barWidth: 3,
                      color: scheme.primary,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, _, __, ___) =>
                            FlDotCirclePainter(radius: 3.5, color: scheme.primary),
                      ),
                    ),
                  ],
                )),
              ),
          ],
        ),
      ),
    );
  }
}
