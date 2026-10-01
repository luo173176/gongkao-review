import 'package:flutter_test/flutter_test.dart';
import 'package:gongkao_review/db/app_db.dart';
import 'package:gongkao_review/services/backup.dart';
import 'package:gongkao_review/services/csv.dart';

void main() {
  test('examToMap / examFromMap 往返一致', () {
    final e = ExamRecord(
      id: 3,
      name: '2026 国考模考（一）',
      type: '模考',
      date: DateTime(2026, 9, 1),
      durationMinutes: 120,
      totalScore: 66.5,
      note: '资料分析超时',
    );
    final e2 = examFromMap(examToMap(e));
    expect(e2, e);
    expect(e2.totalScore, 66.5);
  });

  test('mistakeToMap / mistakeFromMap 往返一致（含特殊字符）', () {
    final m = Mistake(
      id: 7,
      examId: null,
      module: '言语理解',
      knowledgePoint: '中心理解题',
      question: '题干含逗号、双引号"与换行\n第二行',
      myAnswer: 'A',
      correctAnswer: 'C',
      wrongReason: '审题错',
      correctIdea: '先看设问再读文段',
      action: '每天 10 题专项',
      tags: '片段阅读,高频',
      createdAt: DateTime(2026, 9, 2, 10, 30),
    );
    final m2 = mistakeFromMap(mistakeToMap(m));
    expect(m2, m);
    expect(m2.examId, isNull);
  });

  test('review 导出使用 try 字段名（PDCA 兼容）', () {
    final r = Review(
      id: 1,
      examId: 2,
      keep: '资料分析正确率上来了',
      problem: '数量关系用时过长',
      attempt: '先做资料后做数量',
      action: '限时 15 分钟做完数量前 5 题',
      createdAt: DateTime(2026, 9, 3),
    );
    final map = reviewToMap(r);
    expect(map['try'], r.attempt);
    final r2 = reviewFromMap(map);
    expect(r2, r);
  });

  test('encodeBackup / decodeBackup 往返一致', () {
    final data = {
      'app': 'gongkao-review',
      'version': 1,
      'examRecords': [
        examToMap(ExamRecord(
          id: 1,
          name: '套卷A',
          type: '国考',
          date: DateTime(2026, 8, 30),
          durationMinutes: 110,
          totalScore: null,
          note: '',
        )),
      ],
    };
    final decoded = decodeBackup(encodeBackup(data));
    expect(decoded['app'], 'gongkao-review');
    expect(decoded['examRecords'], equals(data['examRecords']));
  });

  group('mistakesCsv', () {
    final m = Mistake(
      id: 1,
      examId: 1,
      module: '言语理解',
      knowledgePoint: '中心理解',
      question: '包含逗号,引号"的题干',
      myAnswer: 'A',
      correctAnswer: 'B',
      wrongReason: '粗心',
      correctIdea: '找主旨句',
      action: '限时训练',
      tags: '片段阅读',
      createdAt: DateTime(2026, 9, 1, 9, 0),
    );

    test('带 BOM 且包含表头', () {
      final csv = mistakesCsv([MistakeCsvRow(examName: '模考一', mistake: m)]);
      expect(csv.startsWith('\uFEFF'), isTrue);
      expect(csv, contains('所属套卷'));
      expect(csv, contains('模考一'));
    });

    test('逗号与引号正确转义', () {
      final csv = mistakesCsv([MistakeCsvRow(examName: 'x', mistake: m)]);
      expect(csv, contains('"包含逗号,引号""的题干"'));
    });

    test('换行字段加引号', () {
      final m2 = Mistake(
        id: 2,
        examId: null,
        module: '',
        knowledgePoint: '',
        question: '第一行\n第二行',
        myAnswer: '',
        correctAnswer: '',
        wrongReason: '其他',
        correctIdea: '',
        action: '',
        tags: '',
        createdAt: DateTime(2026, 9, 1),
      );
      final csv = mistakesCsv([MistakeCsvRow(examName: '', mistake: m2)]);
      expect(csv, contains('"第一行\n第二行"'));
    });
  });
}
