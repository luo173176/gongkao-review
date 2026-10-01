import '../db/app_db.dart';
import '../models/enums.dart';

/// 纯函数统计逻辑，便于单元测试与复用。

double? rate(int correct, int total) => total <= 0 ? null : correct / total;

/// 一张套卷的行测总体正确率（按题数加权汇总）。
double? overallAccuracy(List<Section> sections) {
  final total = sections.fold<int>(0, (a, s) => a + s.totalQuestions);
  final correct = sections.fold<int>(0, (a, s) => a + s.correctQuestions);
  return rate(correct, total);
}

class TrendPoint {
  const TrendPoint(this.date, this.rate, this.label);
  final DateTime date;
  final double rate;
  final String label;
}

/// 按日期升序的正确率趋势点。
List<TrendPoint> trend(List<ExamRecord> exams, List<Section> sections) {
  final byExam = <int, List<Section>>{};
  for (final s in sections) {
    (byExam[s.examId] ??= []).add(s);
  }
  final points = <TrendPoint>[];
  for (final e in exams) {
    final r = overallAccuracy(byExam[e.id] ?? const []);
    if (r != null) points.add(TrendPoint(e.date, r, e.name));
  }
  points.sort((a, b) => a.date.compareTo(b.date));
  return points;
}

class ModuleStat {
  const ModuleStat(this.module, this.accuracy, this.avgMinutes, this.questions);
  final String module;
  final double? accuracy;
  final double avgMinutes;
  final int questions;
}

/// 按模块汇总：正确率（按题数加权）、平均用时。
List<ModuleStat> moduleStats(List<Section> sections) {
  final byModule = <String, List<Section>>{};
  for (final s in sections) {
    (byModule[s.module] ??= []).add(s);
  }
  String orderKey(String m) {
    final i = xingceModules.indexOf(m);
    return i >= 0 ? i.toString().padLeft(2, '0') : '99$m';
  }

  final keys = byModule.keys.toList()..sort((a, b) => orderKey(a).compareTo(orderKey(b)));
  return [
    for (final m in keys)
      () {
        final list = byModule[m]!;
        final total = list.fold<int>(0, (a, s) => a + s.totalQuestions);
        final correct = list.fold<int>(0, (a, s) => a + s.correctQuestions);
        final minutes = list.fold<int>(0, (a, s) => a + s.timeSpentMinutes);
        return ModuleStat(
          m,
          rate(correct, total),
          list.isEmpty ? 0 : minutes / list.length,
          total,
        );
      }(),
  ];
}

/// 错因分布。
Map<String, int> reasonDistribution(List<Mistake> mistakes) {
  final map = <String, int>{};
  for (final m in mistakes) {
    map[m.wrongReason] = (map[m.wrongReason] ?? 0) + 1;
  }
  return map;
}

/// 各模块用时分配（分钟）。
Map<String, int> timeAllocation(List<Section> sections) {
  final map = <String, int>{};
  for (final s in sections) {
    map[s.module] = (map[s.module] ?? 0) + s.timeSpentMinutes;
  }
  return map;
}

/// 行动项完成率。
double actionCompletionRate(List<ActionItem> items) {
  if (items.isEmpty) return 0;
  final done = items.where((i) => i.status == '完成').length;
  return done / items.length;
}

/// 截去时间部分，只保留日期。
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// 行动项是否已逾期（未完成且截止日期早于今天）。
bool isOverdue(ActionItem item, DateTime now) {
  if (item.status == '完成' || item.dueDate == null) return false;
  return item.dueDate!.isBefore(dateOnly(now));
}
