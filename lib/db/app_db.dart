import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

/// 套卷记录
class ExamRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text().withDefault(const Constant('模考'))();
  DateTimeColumn get date => dateTime()();
  IntColumn get durationMinutes => integer().withDefault(const Constant(0))();
  RealColumn get totalScore => real().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

/// 行测模块记录（挂在某张套卷下）
class Sections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().references(ExamRecords, #id)();
  TextColumn get module => text().withLength(min: 1, max: 20)();
  IntColumn get totalQuestions => integer().withDefault(const Constant(0))();
  IntColumn get correctQuestions => integer().withDefault(const Constant(0))();
  IntColumn get timeSpentMinutes => integer().withDefault(const Constant(0))();
  RealColumn get targetRate => real().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

/// 申论记录（挂在某张套卷下）
class EssayRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().references(ExamRecords, #id)();
  TextColumn get questionType => text().withLength(min: 1, max: 50)();
  RealColumn get score => real().nullable()();
  IntColumn get timeSpentMinutes => integer().withDefault(const Constant(0))();
  TextColumn get problem => text().withDefault(const Constant(''))();
  TextColumn get improvement => text().withDefault(const Constant(''))();
}

/// 错题
class Mistakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().nullable().references(ExamRecords, #id)();
  TextColumn get module => text().withDefault(const Constant(''))();
  TextColumn get knowledgePoint => text().withDefault(const Constant(''))();
  TextColumn get question => text().withDefault(const Constant(''))();
  TextColumn get myAnswer => text().withDefault(const Constant(''))();
  TextColumn get correctAnswer => text().withDefault(const Constant(''))();
  TextColumn get wrongReason => text().withDefault(const Constant('知识不会'))();
  TextColumn get correctIdea => text().withDefault(const Constant(''))();
  TextColumn get action => text().withDefault(const Constant(''))();
  TextColumn get tags => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 复盘报告（KPT/PDCA 四字段）
class Reviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().references(ExamRecords, #id)();
  TextColumn get keep => text().withDefault(const Constant(''))();
  TextColumn get problem => text().withDefault(const Constant(''))();
  TextColumn get attempt => text().withDefault(const Constant(''))();
  TextColumn get action => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 行动项
class ActionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get owner => text().withDefault(const Constant('我'))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get priority => text().withDefault(const Constant('中'))();
  TextColumn get status => text().withDefault(const Constant('待办'))();
  IntColumn get relatedExamId => integer().nullable().references(ExamRecords, #id)();
  IntColumn get relatedMistakeId => integer().nullable().references(Mistakes, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

/// 知识卡片
class KnowledgeCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get content => text().withDefault(const Constant(''))();
  TextColumn get cardType => text().withDefault(const Constant('经验卡片'))();
  TextColumn get tags => text().withDefault(const Constant(''))();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [
  ExamRecords,
  Sections,
  EssayRecords,
  Mistakes,
  Reviews,
  ActionItems,
  KnowledgeCards,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 删除套卷及其全部关联数据。
  Future<void> deleteExamCascade(int examId) => transaction(() async {
        await (delete(sections)..where((s) => s.examId.equals(examId))).go();
        await (delete(essayRecords)..where((s) => s.examId.equals(examId))).go();
        await (delete(mistakes)..where((m) => m.examId.equals(examId))).go();
        await (delete(reviews)..where((r) => r.examId.equals(examId))).go();
        await (delete(actionItems)
              ..where((a) => a.relatedExamId.equals(examId)))
            .go();
        await (delete(examRecords)..where((e) => e.id.equals(examId))).go();
      });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'gongkao_review.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
