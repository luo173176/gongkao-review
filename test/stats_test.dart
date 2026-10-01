import 'package:flutter_test/flutter_test.dart';
import 'package:gongkao_review/db/app_db.dart';
import 'package:gongkao_review/services/stats.dart';

void main() {
  Section sec(String module, int total, int correct, {int minutes = 0, double? target}) =>
      Section(
        id: 0,
        examId: 1,
        module: module,
        totalQuestions: total,
        correctQuestions: correct,
        timeSpentMinutes: minutes,
        targetRate: target,
        note: '',
      );

  group('overallAccuracy', () {
    test('按题数加权汇总', () {
      final secs = [sec('常识判断', 20, 10), sec('言语理解', 40, 30)];
      final r = overallAccuracy(secs);
      expect(r, closeTo(40 / 60, 1e-9));
    });

    test('无数据返回 null', () {
      expect(overallAccuracy(const []), isNull);
      expect(overallAccuracy([sec('常识判断', 0, 0)]), isNull);
    });
  });

  group('moduleStats', () {
    test('按模块汇总正确率与平均用时，并按固定模块顺序输出', () {
      final secs = [
        sec('资料分析', 20, 16, minutes: 30),
        sec('常识判断', 20, 10, minutes: 10),
        sec('常识判断', 10, 5, minutes: 6),
      ];
      final stats = moduleStats(secs);
      expect(stats.map((m) => m.module).toList(),
          ['常识判断', '资料分析']);
      expect(stats[0].accuracy, closeTo(15 / 30, 1e-9));
      expect(stats[0].avgMinutes, closeTo(8, 1e-9));
      expect(stats[0].questions, 30);
    });
  });

  test('reasonDistribution 统计错因次数', () {
    Mistake m(String reason) => Mistake(
          id: 0,
          examId: null,
          module: '',
          knowledgePoint: '',
          question: '',
          myAnswer: '',
          correctAnswer: '',
          wrongReason: reason,
          correctIdea: '',
          action: '',
          tags: '',
          createdAt: DateTime(2026, 9, 1),
        );
    final dist = reasonDistribution([m('粗心'), m('粗心'), m('蒙错')]);
    expect(dist, {'粗心': 2, '蒙错': 1});
  });

  group('行动项', () {
    ActionItem item(String status, DateTime? due) => ActionItem(
          id: 0,
          title: 't',
          owner: '我',
          dueDate: due,
          priority: '中',
          status: status,
          relatedExamId: null,
          relatedMistakeId: null,
          createdAt: DateTime(2026, 9, 1),
          completedAt: null,
        );

    test('actionCompletionRate', () {
      final items = [
        item('完成', null),
        item('待办', null),
        item('进行中', null),
      ];
      expect(actionCompletionRate(items), closeTo(1 / 3, 1e-9));
      expect(actionCompletionRate(const []), 0);
    });

    test('isOverdue 逾期判定', () {
      final now = DateTime(2026, 9, 10, 15);
      expect(isOverdue(item('待办', DateTime(2026, 9, 9)), now), isTrue);
      expect(isOverdue(item('待办', DateTime(2026, 9, 10)), now), isFalse,
          reason: '今天截止不算逾期');
      expect(isOverdue(item('完成', DateTime(2026, 9, 1)), now), isFalse);
      expect(isOverdue(item('待办', null), now), isFalse);
    });
  });
}
