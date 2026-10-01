import 'dart:convert';

import 'package:drift/drift.dart';

import '../db/app_db.dart';

/// JSON 备份/恢复与清空数据。
/// 行映射为手写实现，便于对导出格式做单元测试并保持跨版本稳定。

// ---------------- 行 <-> Map ----------------

Map<String, Object?> examToMap(ExamRecord e) => {
      'id': e.id,
      'name': e.name,
      'type': e.type,
      'date': e.date.toIso8601String(),
      'durationMinutes': e.durationMinutes,
      'totalScore': e.totalScore,
      'note': e.note,
    };

ExamRecord examFromMap(Map<String, Object?> m) => ExamRecord(
      id: (m['id'] as num).toInt(),
      name: m['name'] as String? ?? '',
      type: m['type'] as String? ?? '模考',
      date: DateTime.parse(m['date'] as String),
      durationMinutes: ((m['durationMinutes'] as num?) ?? 0).toInt(),
      totalScore: (m['totalScore'] as num?)?.toDouble(),
      note: m['note'] as String? ?? '',
    );

Map<String, Object?> sectionToMap(Section s) => {
      'id': s.id,
      'examId': s.examId,
      'module': s.module,
      'totalQuestions': s.totalQuestions,
      'correctQuestions': s.correctQuestions,
      'timeSpentMinutes': s.timeSpentMinutes,
      'targetRate': s.targetRate,
      'note': s.note,
    };

Section sectionFromMap(Map<String, Object?> m) => Section(
      id: (m['id'] as num).toInt(),
      examId: (m['examId'] as num).toInt(),
      module: m['module'] as String? ?? '',
      totalQuestions: ((m['totalQuestions'] as num?) ?? 0).toInt(),
      correctQuestions: ((m['correctQuestions'] as num?) ?? 0).toInt(),
      timeSpentMinutes: ((m['timeSpentMinutes'] as num?) ?? 0).toInt(),
      targetRate: (m['targetRate'] as num?)?.toDouble(),
      note: m['note'] as String? ?? '',
    );

Map<String, Object?> essayToMap(EssayRecord e) => {
      'id': e.id,
      'examId': e.examId,
      'questionType': e.questionType,
      'score': e.score,
      'timeSpentMinutes': e.timeSpentMinutes,
      'problem': e.problem,
      'improvement': e.improvement,
    };

EssayRecord essayFromMap(Map<String, Object?> m) => EssayRecord(
      id: (m['id'] as num).toInt(),
      examId: (m['examId'] as num).toInt(),
      questionType: m['questionType'] as String? ?? '',
      score: (m['score'] as num?)?.toDouble(),
      timeSpentMinutes: ((m['timeSpentMinutes'] as num?) ?? 0).toInt(),
      problem: m['problem'] as String? ?? '',
      improvement: m['improvement'] as String? ?? '',
    );

Map<String, Object?> mistakeToMap(Mistake m) => {
      'id': m.id,
      'examId': m.examId,
      'module': m.module,
      'knowledgePoint': m.knowledgePoint,
      'question': m.question,
      'myAnswer': m.myAnswer,
      'correctAnswer': m.correctAnswer,
      'wrongReason': m.wrongReason,
      'correctIdea': m.correctIdea,
      'action': m.action,
      'tags': m.tags,
      'createdAt': m.createdAt.toIso8601String(),
    };

Mistake mistakeFromMap(Map<String, Object?> m) => Mistake(
      id: (m['id'] as num).toInt(),
      examId: (m['examId'] as num?)?.toInt(),
      module: m['module'] as String? ?? '',
      knowledgePoint: m['knowledgePoint'] as String? ?? '',
      question: m['question'] as String? ?? '',
      myAnswer: m['myAnswer'] as String? ?? '',
      correctAnswer: m['correctAnswer'] as String? ?? '',
      wrongReason: m['wrongReason'] as String? ?? '知识不会',
      correctIdea: m['correctIdea'] as String? ?? '',
      action: m['action'] as String? ?? '',
      tags: m['tags'] as String? ?? '',
      createdAt: DateTime.parse(m['createdAt'] as String),
    );

Map<String, Object?> reviewToMap(Review r) => {
      'id': r.id,
      'examId': r.examId,
      'keep': r.keep,
      'problem': r.problem,
      'try': r.attempt,
      'action': r.action,
      'createdAt': r.createdAt.toIso8601String(),
    };

Review reviewFromMap(Map<String, Object?> m) => Review(
      id: (m['id'] as num).toInt(),
      examId: (m['examId'] as num).toInt(),
      keep: m['keep'] as String? ?? '',
      problem: m['problem'] as String? ?? '',
      attempt: m['try'] as String? ?? '',
      action: m['action'] as String? ?? '',
      createdAt: DateTime.parse(m['createdAt'] as String),
    );

Map<String, Object?> actionItemToMap(ActionItem a) => {
      'id': a.id,
      'title': a.title,
      'owner': a.owner,
      'dueDate': a.dueDate?.toIso8601String(),
      'priority': a.priority,
      'status': a.status,
      'relatedExamId': a.relatedExamId,
      'relatedMistakeId': a.relatedMistakeId,
      'createdAt': a.createdAt.toIso8601String(),
      'completedAt': a.completedAt?.toIso8601String(),
    };

ActionItem actionItemFromMap(Map<String, Object?> m) => ActionItem(
      id: (m['id'] as num).toInt(),
      title: m['title'] as String? ?? '',
      owner: m['owner'] as String? ?? '我',
      dueDate: m['dueDate'] == null ? null : DateTime.parse(m['dueDate'] as String),
      priority: m['priority'] as String? ?? '中',
      status: m['status'] as String? ?? '待办',
      relatedExamId: (m['relatedExamId'] as num?)?.toInt(),
      relatedMistakeId: (m['relatedMistakeId'] as num?)?.toInt(),
      createdAt: DateTime.parse(m['createdAt'] as String),
      completedAt:
          m['completedAt'] == null ? null : DateTime.parse(m['completedAt'] as String),
    );

Map<String, Object?> cardToMap(KnowledgeCard c) => {
      'id': c.id,
      'title': c.title,
      'content': c.content,
      'cardType': c.cardType,
      'tags': c.tags,
      'favorite': c.favorite,
      'createdAt': c.createdAt.toIso8601String(),
    };

KnowledgeCard cardFromMap(Map<String, Object?> m) => KnowledgeCard(
      id: (m['id'] as num).toInt(),
      title: m['title'] as String? ?? '',
      content: m['content'] as String? ?? '',
      cardType: m['cardType'] as String? ?? '经验卡片',
      tags: m['tags'] as String? ?? '',
      favorite: (m['favorite'] as bool?) ?? false,
      createdAt: DateTime.parse(m['createdAt'] as String),
    );

// ---------------- 导出 / 导入 ----------------

Future<Map<String, Object?>> exportAll(AppDatabase db) async {
  return {
    'app': 'gongkao-review',
    'version': 1,
    'exportedAt': DateTime.now().toIso8601String(),
    'examRecords':
        (await db.select(db.examRecords).get()).map(examToMap).toList(),
    'sections': (await db.select(db.sections).get()).map(sectionToMap).toList(),
    'essayRecords':
        (await db.select(db.essayRecords).get()).map(essayToMap).toList(),
    'mistakes': (await db.select(db.mistakes).get()).map(mistakeToMap).toList(),
    'reviews': (await db.select(db.reviews).get()).map(reviewToMap).toList(),
    'actionItems':
        (await db.select(db.actionItems).get()).map(actionItemToMap).toList(),
    'knowledgeCards':
        (await db.select(db.knowledgeCards).get()).map(cardToMap).toList(),
  };
}

/// 清空所有业务表（先子表后父表）。
Future<void> clearAll(AppDatabase db) async {
  await db.transaction(() async {
    await db.delete(db.sections).go();
    await db.delete(db.essayRecords).go();
    await db.delete(db.mistakes).go();
    await db.delete(db.reviews).go();
    await db.delete(db.actionItems).go();
    await db.delete(db.knowledgeCards).go();
    await db.delete(db.examRecords).go();
  });
}

/// 导入备份：清空现有数据后整体写入。
Future<void> importAll(AppDatabase db, Map<String, Object?> data) async {
  if (data['app'] != 'gongkao-review') {
    throw const FormatException('不是有效的考公复盘备份文件');
  }
  List<Map<String, Object?>> listOf(String key) =>
      ((data[key] as List?) ?? const [])
          .whereType<Map>()
          .map((m) => m.cast<String, Object?>())
          .toList();

  await clearAll(db);
  await db.transaction(() async {
    for (final m in listOf('examRecords')) {
      await db.into(db.examRecords).insert(examCompanionFromMap(m));
    }
    for (final m in listOf('sections')) {
      await db.into(db.sections).insert(sectionCompanionFromMap(m));
    }
    for (final m in listOf('essayRecords')) {
      await db.into(db.essayRecords).insert(essayCompanionFromMap(m));
    }
    for (final m in listOf('mistakes')) {
      await db.into(db.mistakes).insert(mistakeCompanionFromMap(m));
    }
    for (final m in listOf('reviews')) {
      await db.into(db.reviews).insert(reviewCompanionFromMap(m));
    }
    for (final m in listOf('actionItems')) {
      await db.into(db.actionItems).insert(actionCompanionFromMap(m));
    }
    for (final m in listOf('knowledgeCards')) {
      await db.into(db.knowledgeCards).insert(cardCompanionFromMap(m));
    }
  });
}

// ---------------- Companion 构造（导入用） ----------------

ExamRecordsCompanion examCompanionFromMap(Map<String, Object?> m) =>
    ExamRecordsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      name: m['name'] as String? ?? '',
      type: Value(m['type'] as String? ?? '模考'),
      date: DateTime.parse(m['date'] as String),
      durationMinutes: Value(((m['durationMinutes'] as num?) ?? 0).toInt()),
      totalScore: Value((m['totalScore'] as num?)?.toDouble()),
      note: Value(m['note'] as String? ?? ''),
    );

SectionsCompanion sectionCompanionFromMap(Map<String, Object?> m) =>
    SectionsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      examId: (m['examId'] as num).toInt(),
      module: m['module'] as String? ?? '',
      totalQuestions: Value(((m['totalQuestions'] as num?) ?? 0).toInt()),
      correctQuestions: Value(((m['correctQuestions'] as num?) ?? 0).toInt()),
      timeSpentMinutes: Value(((m['timeSpentMinutes'] as num?) ?? 0).toInt()),
      targetRate: Value((m['targetRate'] as num?)?.toDouble()),
      note: Value(m['note'] as String? ?? ''),
    );

EssayRecordsCompanion essayCompanionFromMap(Map<String, Object?> m) =>
    EssayRecordsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      examId: (m['examId'] as num).toInt(),
      questionType: m['questionType'] as String? ?? '',
      score: Value((m['score'] as num?)?.toDouble()),
      timeSpentMinutes: Value(((m['timeSpentMinutes'] as num?) ?? 0).toInt()),
      problem: Value(m['problem'] as String? ?? ''),
      improvement: Value(m['improvement'] as String? ?? ''),
    );

MistakesCompanion mistakeCompanionFromMap(Map<String, Object?> m) =>
    MistakesCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      examId: Value((m['examId'] as num?)?.toInt()),
      module: Value(m['module'] as String? ?? ''),
      knowledgePoint: Value(m['knowledgePoint'] as String? ?? ''),
      question: Value(m['question'] as String? ?? ''),
      myAnswer: Value(m['myAnswer'] as String? ?? ''),
      correctAnswer: Value(m['correctAnswer'] as String? ?? ''),
      wrongReason: Value(m['wrongReason'] as String? ?? '知识不会'),
      correctIdea: Value(m['correctIdea'] as String? ?? ''),
      action: Value(m['action'] as String? ?? ''),
      tags: Value(m['tags'] as String? ?? ''),
      createdAt: Value(DateTime.parse(m['createdAt'] as String)),
    );

ReviewsCompanion reviewCompanionFromMap(Map<String, Object?> m) =>
    ReviewsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      examId: (m['examId'] as num).toInt(),
      keep: Value(m['keep'] as String? ?? ''),
      problem: Value(m['problem'] as String? ?? ''),
      attempt: Value(m['try'] as String? ?? ''),
      action: Value(m['action'] as String? ?? ''),
      createdAt: Value(DateTime.parse(m['createdAt'] as String)),
    );

ActionItemsCompanion actionCompanionFromMap(Map<String, Object?> m) =>
    ActionItemsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      title: m['title'] as String? ?? '',
      owner: Value(m['owner'] as String? ?? '我'),
      dueDate: Value(m['dueDate'] == null
          ? null
          : DateTime.parse(m['dueDate'] as String)),
      priority: Value(m['priority'] as String? ?? '中'),
      status: Value(m['status'] as String? ?? '待办'),
      relatedExamId: Value((m['relatedExamId'] as num?)?.toInt()),
      relatedMistakeId: Value((m['relatedMistakeId'] as num?)?.toInt()),
      createdAt: Value(DateTime.parse(m['createdAt'] as String)),
      completedAt: Value(m['completedAt'] == null
          ? null
          : DateTime.parse(m['completedAt'] as String)),
    );

KnowledgeCardsCompanion cardCompanionFromMap(Map<String, Object?> m) =>
    KnowledgeCardsCompanion.insert(
      id: Value((m['id'] as num).toInt()),
      title: m['title'] as String? ?? '',
      content: Value(m['content'] as String? ?? ''),
      cardType: Value(m['cardType'] as String? ?? '经验卡片'),
      tags: Value(m['tags'] as String? ?? ''),
      favorite: Value((m['favorite'] as bool?) ?? false),
      createdAt: Value(DateTime.parse(m['createdAt'] as String)),
    );

/// 将导出数据编码为格式化 JSON 字符串。
String encodeBackup(Map<String, Object?> data) =>
    const JsonEncoder.withIndent('  ').convert(data);

/// 解析备份 JSON 文本。
Map<String, Object?> decodeBackup(String text) {
  final obj = jsonDecode(text);
  if (obj is! Map<String, Object?>) {
    if (obj is Map) return obj.cast<String, Object?>();
    throw const FormatException('备份文件格式不正确');
  }
  return obj;
}
