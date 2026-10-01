import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/app_db.dart';

/// 在 main() 中通过 override 注入已初始化的 SharedPreferences。
final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('prefsProvider 必须在 main() 中 override');
});

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ---------------- 设置 ----------------

class AppSettings {
  const AppSettings({
    this.examDate,
    this.targetScore,
    this.themeMode = ThemeMode.system,
    this.owner = '我',
  });

  final DateTime? examDate;
  final double? targetScore;
  final ThemeMode themeMode;
  final String owner;

  AppSettings copyWith({
    DateTime? examDate,
    bool clearExamDate = false,
    double? targetScore,
    bool clearTargetScore = false,
    ThemeMode? themeMode,
    String? owner,
  }) {
    return AppSettings(
      examDate: clearExamDate ? null : (examDate ?? this.examDate),
      targetScore:
          clearTargetScore ? null : (targetScore ?? this.targetScore),
      themeMode: themeMode ?? this.themeMode,
      owner: owner ?? this.owner,
    );
  }
}

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final prefs = ref.read(prefsProvider);
    final dateStr = prefs.getString('examDate');
    final modeStr = prefs.getString('themeMode');
    return AppSettings(
      examDate:
          dateStr == null ? null : DateTime.tryParse(dateStr)?.toLocal(),
      targetScore: prefs.getDouble('targetScore'),
      themeMode: switch (modeStr) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      owner: prefs.getString('owner') ?? '我',
    );
  }

  SharedPreferences get _prefs => ref.read(prefsProvider);

  Future<void> setExamDate(DateTime? date) async {
    state = date == null
        ? state.copyWith(clearExamDate: true)
        : state.copyWith(examDate: date);
    if (date == null) {
      await _prefs.remove('examDate');
    } else {
      await _prefs.setString('examDate', date.toIso8601String());
    }
  }

  Future<void> setTargetScore(double? value) async {
    state = value == null
        ? state.copyWith(clearTargetScore: true)
        : state.copyWith(targetScore: value);
    if (value == null) {
      await _prefs.remove('targetScore');
    } else {
      await _prefs.setDouble('targetScore', value);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setString('themeMode', mode.name);
  }

  Future<void> setOwner(String name) async {
    state = state.copyWith(owner: name);
    await _prefs.setString('owner', name);
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);

// ---------------- 数据流 ----------------

final examsProvider = StreamProvider<List<ExamRecord>>((ref) {
  final db = ref.watch(dbProvider);
  return (db.select(db.examRecords)
        ..orderBy([(e) => OrderingTerm.desc(e.date)]))
      .watch();
});

final examByIdProvider = FutureProvider.family<ExamRecord?, int>((ref, id) {
  final db = ref.watch(dbProvider);
  return (db.select(db.examRecords)..where((e) => e.id.equals(id)))
      .getSingleOrNull();
});

final allSectionsProvider = StreamProvider<List<Section>>((ref) {
  final db = ref.watch(dbProvider);
  return db.select(db.sections).watch();
});

final sectionsProvider =
    StreamProvider.family<List<Section>, int>((ref, examId) {
  final db = ref.watch(dbProvider);
  return (db.select(db.sections)..where((s) => s.examId.equals(examId)))
      .watch();
});

final essaysProvider =
    StreamProvider.family<List<EssayRecord>, int>((ref, examId) {
  final db = ref.watch(dbProvider);
  return (db.select(db.essayRecords)..where((s) => s.examId.equals(examId)))
      .watch();
});

final mistakesProvider = StreamProvider<List<Mistake>>((ref) {
  final db = ref.watch(dbProvider);
  return (db.select(db.mistakes)
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
      .watch();
});

final mistakesOfExamProvider =
    StreamProvider.family<List<Mistake>, int>((ref, examId) {
  final db = ref.watch(dbProvider);
  return (db.select(db.mistakes)
        ..where((m) => m.examId.equals(examId))
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
      .watch();
});

final reviewsOfExamProvider =
    StreamProvider.family<List<Review>, int>((ref, examId) {
  final db = ref.watch(dbProvider);
  return (db.select(db.reviews)
        ..where((r) => r.examId.equals(examId))
        ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
      .watch();
});

final actionItemsProvider = StreamProvider<List<ActionItem>>((ref) {
  final db = ref.watch(dbProvider);
  return (db.select(db.actionItems)
        ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
      .watch();
});

final cardsProvider = StreamProvider<List<KnowledgeCard>>((ref) {
  final db = ref.watch(dbProvider);
  return (db.select(db.knowledgeCards)
        ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]))
      .watch();
});
