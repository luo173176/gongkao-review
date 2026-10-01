import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import '../widgets/common.dart';

const _moduleColors = [
  Color(0xFF4C78A8),
  Color(0xFF54A24B),
  Color(0xFFE45756),
  Color(0xFF72B7B2),
  Color(0xFFB279A2),
];

const _reasonColors = [
  Color(0xFF4C78A8),
  Color(0xFFF58518),
  Color(0xFFE45756),
  Color(0xFF72B7B2),
  Color(0xFF54A24B),
  Color(0xFFEECA3B),
  Color(0xFFB279A2),
  Color(0xFFFF9D9E),
];

final _rangeProvider = StateProvider<int>((ref) => 2);

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(_rangeProvider);
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final allSections =
        ref.watch(allSectionsProvider).valueOrNull ?? const <Section>[];
    final mistakes =
        ref.watch(mistakesProvider).valueOrNull ?? const <Mistake>[];
    final actions =
        ref.watch(actionItemsProvider).valueOrNull ?? const <ActionItem>[];

    final now = DateTime.now();
    final DateTime? from = switch (range) {
      0 => now.subtract(const Duration(days: 7)),
      1 => now.subtract(const Duration(days: 30)),
      _ => null,
    };
    bool inRange(DateTime d) => from == null || !d.isBefore(dateOnly(from));

    final examsInRange =
        exams.where((e) => inRange(e.date)).toList();
    final examIds = {for (final e in examsInRange) e.id};
    final sections =
        allSections.where((s) => examIds.contains(s.examId)).toList();
    final mistakesInRange =
        mistakes.where((m) => inRange(m.createdAt)).toList();

    final trendPts = trend(examsInRange, sections);
    final mods = moduleStats(sections)
        .where((m) => m.questions > 0)
        .toList();
    final times = timeAllocation(sections);
    final reasons = reasonDistribution(mistakesInRange);
    final doneCount = actions.where((a) => a.status == '完成').length;
    final actionRate = actionCompletionRate(actions);

    return Scaffold(
      appBar: AppBar(title: const Text('统计')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('近 7 天')),
              ButtonSegment(value: 1, label: Text('近 30 天')),
              ButtonSegment(value: 2, label: Text('全部')),
            ],
            selected: {range},
            onSelectionChanged: (s) =>
                ref.read(_rangeProvider.notifier).state = s.first,
          ),
          const SizedBox(height: 16),
          _card(
            context,
            title: '正确率趋势',
            child: trendPts.length < 2
                ? _empty('记录 2 张以上套卷后显示趋势')
                : SizedBox(
                    height: 200,
                    child: _TrendChart(points: trendPts),
                  ),
          ),
          const SizedBox(height: 16),
          _card(
            context,
            title: '模块强弱对比（正确率%）',
            child: mods.isEmpty
                ? _empty('暂无模块数据')
                : SizedBox(
                    height: 200,
                    child: _ModuleBarChart(
                      stats: mods,
                      colors: _moduleColors,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          _card(
            context,
            title: '时间分配（分钟）',
            child: times.isEmpty
                ? _empty('暂无用时数据')
                : Column(
                    children: [
                      for (final e in times.entries)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 76,
                                  child: Text(e.key,
                                      style: const TextStyle(fontSize: 13))),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: e.value /
                                      (times.values
                                              .fold<int>(0, (a, b) => a + b))
                                          .clamp(1, 1 << 31),
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                  width: 44,
                                  child: Text('${e.value} 分',
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.right)),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          _card(
            context,
            title: '错因分布',
            child: reasons.isEmpty
                ? _empty('暂无错题数据')
                : SizedBox(
                    height: 220,
                    child: _ReasonPieChart(reasons: reasons),
                  ),
          ),
          const SizedBox(height: 16),
          _card(
            context,
            title: '行动项完成率',
            child: actions.isEmpty
                ? _empty('还没有行动项')
                : Column(
                    children: [
                      Row(children: [
                        Text(
                          '${(actionRate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('$doneCount / ${actions.length} 项已完成'),
                      ]),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: actionRate,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required String title, required Widget child}) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _empty(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
          child: Text(text, style: const TextStyle(color: Colors.grey))),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points});

  final List<TrendPoint> points;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LineChart(LineChartData(
      minX: 0,
      maxX: (points.length - 1).toDouble(),
      minY: 0,
      maxY: 100,
      gridData: const FlGridData(
              show: true, drawVerticalLine: false, horizontalInterval: 25),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 25,
            reservedSize: 36,
            getTitlesWidget: (v, meta) => Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text('${v.toInt()}%',
                  style: const TextStyle(fontSize: 10)),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 26,
            interval: ((points.length - 1) / 6).clamp(1, 1 << 31).toDouble(),
            getTitlesWidget: (v, meta) {
              final i = v.toInt();
              if (i < 0 || i >= points.length) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(fmtDate(points[i].date).substring(5),
                    style: const TextStyle(fontSize: 10)),
              );
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var i = 0; i < points.length; i++)
              FlSpot(i.toDouble(), (points[i].rate * 100).clamp(0, 100)),
          ],
          isCurved: true,
          barWidth: 3,
          color: scheme.primary,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, _, __, ___) =>
                FlDotCirclePainter(radius: 3, color: scheme.primary),
          ),
        ),
      ],
    ));
  }
}

class _ModuleBarChart extends StatelessWidget {
  const _ModuleBarChart({required this.stats, required this.colors});

  final List<ModuleStat> stats;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 100,
      barTouchData: BarTouchData(enabled: false),
      gridData: const FlGridData(
              show: true, drawVerticalLine: false, horizontalInterval: 25),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 25,
            reservedSize: 32,
            getTitlesWidget: (v, meta) => Text('${v.toInt()}',
                style: const TextStyle(fontSize: 10)),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 34,
            getTitlesWidget: (v, meta) {
              final i = v.toInt();
              if (i < 0 || i >= stats.length) return const SizedBox.shrink();
              final acc = stats[i].accuracy;
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '${stats[i].module.substring(0, 2)}\n${acc == null ? '--' : (acc * 100).toStringAsFixed(0)}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, height: 1.3),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: [
        for (var i = 0; i < stats.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: (stats[i].accuracy ?? 0) * 100,
                width: 18,
                color: colors[i % colors.length],
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4)),
              ),
            ],
          ),
      ],
    ));
  }
}

class _ReasonPieChart extends StatelessWidget {
  const _ReasonPieChart({required this.reasons});

  final Map<String, int> reasons;

  @override
  Widget build(BuildContext context) {
    final entries = reasons.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = entries.fold<int>(0, (a, e) => a + e.value);
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: PieChart(PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 38,
            sections: [
              for (var i = 0; i < entries.length; i++)
                PieChartSectionData(
                  value: entries[i].value.toDouble(),
                  color: _reasonColors[i % _reasonColors.length],
                  radius: 42,
                  title:
                      '${(entries[i].value / total * 100).toStringAsFixed(0)}%',
                  titleStyle: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
            ],
          )),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < entries.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _reasonColors[i % _reasonColors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('${entries[i].key} ${entries[i].value}',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
