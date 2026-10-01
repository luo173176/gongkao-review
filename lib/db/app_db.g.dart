// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $ExamRecordsTable extends ExamRecords
    with TableInfo<$ExamRecordsTable, ExamRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('模考'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalScoreMeta =
      const VerificationMeta('totalScore');
  @override
  late final GeneratedColumn<double> totalScore = GeneratedColumn<double>(
      'total_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, date, durationMinutes, totalScore, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_records';
  @override
  VerificationContext validateIntegrity(Insertable<ExamRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('total_score')) {
      context.handle(
          _totalScoreMeta,
          totalScore.isAcceptableOrUnknown(
              data['total_score']!, _totalScoreMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      totalScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_score']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
    );
  }

  @override
  $ExamRecordsTable createAlias(String alias) {
    return $ExamRecordsTable(attachedDatabase, alias);
  }
}

class ExamRecord extends DataClass implements Insertable<ExamRecord> {
  final int id;
  final String name;
  final String type;
  final DateTime date;
  final int durationMinutes;
  final double? totalScore;
  final String note;
  const ExamRecord(
      {required this.id,
      required this.name,
      required this.type,
      required this.date,
      required this.durationMinutes,
      this.totalScore,
      required this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || totalScore != null) {
      map['total_score'] = Variable<double>(totalScore);
    }
    map['note'] = Variable<String>(note);
    return map;
  }

  ExamRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExamRecordsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      date: Value(date),
      durationMinutes: Value(durationMinutes),
      totalScore: totalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(totalScore),
      note: Value(note),
    );
  }

  factory ExamRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamRecord(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      totalScore: serializer.fromJson<double?>(json['totalScore']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'totalScore': serializer.toJson<double?>(totalScore),
      'note': serializer.toJson<String>(note),
    };
  }

  ExamRecord copyWith(
          {int? id,
          String? name,
          String? type,
          DateTime? date,
          int? durationMinutes,
          Value<double?> totalScore = const Value.absent(),
          String? note}) =>
      ExamRecord(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        date: date ?? this.date,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        totalScore: totalScore.present ? totalScore.value : this.totalScore,
        note: note ?? this.note,
      );
  ExamRecord copyWithCompanion(ExamRecordsCompanion data) {
    return ExamRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      totalScore:
          data.totalScore.present ? data.totalScore.value : this.totalScore,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('totalScore: $totalScore, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, date, durationMinutes, totalScore, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.date == this.date &&
          other.durationMinutes == this.durationMinutes &&
          other.totalScore == this.totalScore &&
          other.note == this.note);
}

class ExamRecordsCompanion extends UpdateCompanion<ExamRecord> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<int> durationMinutes;
  final Value<double?> totalScore;
  final Value<String> note;
  const ExamRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.note = const Value.absent(),
  });
  ExamRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    required DateTime date,
    this.durationMinutes = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.note = const Value.absent(),
  })  : name = Value(name),
        date = Value(date);
  static Insertable<ExamRecord> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<int>? durationMinutes,
    Expression<double>? totalScore,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (totalScore != null) 'total_score': totalScore,
      if (note != null) 'note': note,
    });
  }

  ExamRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? date,
      Value<int>? durationMinutes,
      Value<double?>? totalScore,
      Value<String>? note}) {
    return ExamRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      totalScore: totalScore ?? this.totalScore,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<double>(totalScore.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('totalScore: $totalScore, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SectionsTable extends Sections with TableInfo<$SectionsTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exam_records (id)'));
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
      'module', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _totalQuestionsMeta =
      const VerificationMeta('totalQuestions');
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
      'total_questions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _correctQuestionsMeta =
      const VerificationMeta('correctQuestions');
  @override
  late final GeneratedColumn<int> correctQuestions = GeneratedColumn<int>(
      'correct_questions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timeSpentMinutesMeta =
      const VerificationMeta('timeSpentMinutes');
  @override
  late final GeneratedColumn<int> timeSpentMinutes = GeneratedColumn<int>(
      'time_spent_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _targetRateMeta =
      const VerificationMeta('targetRate');
  @override
  late final GeneratedColumn<double> targetRate = GeneratedColumn<double>(
      'target_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        module,
        totalQuestions,
        correctQuestions,
        timeSpentMinutes,
        targetRate,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(Insertable<Section> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('module')) {
      context.handle(_moduleMeta,
          module.isAcceptableOrUnknown(data['module']!, _moduleMeta));
    } else if (isInserting) {
      context.missing(_moduleMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
          _totalQuestionsMeta,
          totalQuestions.isAcceptableOrUnknown(
              data['total_questions']!, _totalQuestionsMeta));
    }
    if (data.containsKey('correct_questions')) {
      context.handle(
          _correctQuestionsMeta,
          correctQuestions.isAcceptableOrUnknown(
              data['correct_questions']!, _correctQuestionsMeta));
    }
    if (data.containsKey('time_spent_minutes')) {
      context.handle(
          _timeSpentMinutesMeta,
          timeSpentMinutes.isAcceptableOrUnknown(
              data['time_spent_minutes']!, _timeSpentMinutesMeta));
    }
    if (data.containsKey('target_rate')) {
      context.handle(
          _targetRateMeta,
          targetRate.isAcceptableOrUnknown(
              data['target_rate']!, _targetRateMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id'])!,
      module: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}module'])!,
      totalQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_questions'])!,
      correctQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_questions'])!,
      timeSpentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}time_spent_minutes'])!,
      targetRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_rate']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}

class Section extends DataClass implements Insertable<Section> {
  final int id;
  final int examId;
  final String module;
  final int totalQuestions;
  final int correctQuestions;
  final int timeSpentMinutes;
  final double? targetRate;
  final String note;
  const Section(
      {required this.id,
      required this.examId,
      required this.module,
      required this.totalQuestions,
      required this.correctQuestions,
      required this.timeSpentMinutes,
      this.targetRate,
      required this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exam_id'] = Variable<int>(examId);
    map['module'] = Variable<String>(module);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['correct_questions'] = Variable<int>(correctQuestions);
    map['time_spent_minutes'] = Variable<int>(timeSpentMinutes);
    if (!nullToAbsent || targetRate != null) {
      map['target_rate'] = Variable<double>(targetRate);
    }
    map['note'] = Variable<String>(note);
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      examId: Value(examId),
      module: Value(module),
      totalQuestions: Value(totalQuestions),
      correctQuestions: Value(correctQuestions),
      timeSpentMinutes: Value(timeSpentMinutes),
      targetRate: targetRate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRate),
      note: Value(note),
    );
  }

  factory Section.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int>(json['examId']),
      module: serializer.fromJson<String>(json['module']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      correctQuestions: serializer.fromJson<int>(json['correctQuestions']),
      timeSpentMinutes: serializer.fromJson<int>(json['timeSpentMinutes']),
      targetRate: serializer.fromJson<double?>(json['targetRate']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int>(examId),
      'module': serializer.toJson<String>(module),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'correctQuestions': serializer.toJson<int>(correctQuestions),
      'timeSpentMinutes': serializer.toJson<int>(timeSpentMinutes),
      'targetRate': serializer.toJson<double?>(targetRate),
      'note': serializer.toJson<String>(note),
    };
  }

  Section copyWith(
          {int? id,
          int? examId,
          String? module,
          int? totalQuestions,
          int? correctQuestions,
          int? timeSpentMinutes,
          Value<double?> targetRate = const Value.absent(),
          String? note}) =>
      Section(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        module: module ?? this.module,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        correctQuestions: correctQuestions ?? this.correctQuestions,
        timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
        targetRate: targetRate.present ? targetRate.value : this.targetRate,
        note: note ?? this.note,
      );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      module: data.module.present ? data.module.value : this.module,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      correctQuestions: data.correctQuestions.present
          ? data.correctQuestions.value
          : this.correctQuestions,
      timeSpentMinutes: data.timeSpentMinutes.present
          ? data.timeSpentMinutes.value
          : this.timeSpentMinutes,
      targetRate:
          data.targetRate.present ? data.targetRate.value : this.targetRate,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('module: $module, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctQuestions: $correctQuestions, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('targetRate: $targetRate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, examId, module, totalQuestions,
      correctQuestions, timeSpentMinutes, targetRate, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.module == this.module &&
          other.totalQuestions == this.totalQuestions &&
          other.correctQuestions == this.correctQuestions &&
          other.timeSpentMinutes == this.timeSpentMinutes &&
          other.targetRate == this.targetRate &&
          other.note == this.note);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<int> id;
  final Value<int> examId;
  final Value<String> module;
  final Value<int> totalQuestions;
  final Value<int> correctQuestions;
  final Value<int> timeSpentMinutes;
  final Value<double?> targetRate;
  final Value<String> note;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.module = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.correctQuestions = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.targetRate = const Value.absent(),
    this.note = const Value.absent(),
  });
  SectionsCompanion.insert({
    this.id = const Value.absent(),
    required int examId,
    required String module,
    this.totalQuestions = const Value.absent(),
    this.correctQuestions = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.targetRate = const Value.absent(),
    this.note = const Value.absent(),
  })  : examId = Value(examId),
        module = Value(module);
  static Insertable<Section> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<String>? module,
    Expression<int>? totalQuestions,
    Expression<int>? correctQuestions,
    Expression<int>? timeSpentMinutes,
    Expression<double>? targetRate,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (module != null) 'module': module,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (correctQuestions != null) 'correct_questions': correctQuestions,
      if (timeSpentMinutes != null) 'time_spent_minutes': timeSpentMinutes,
      if (targetRate != null) 'target_rate': targetRate,
      if (note != null) 'note': note,
    });
  }

  SectionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? examId,
      Value<String>? module,
      Value<int>? totalQuestions,
      Value<int>? correctQuestions,
      Value<int>? timeSpentMinutes,
      Value<double?>? targetRate,
      Value<String>? note}) {
    return SectionsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      module: module ?? this.module,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctQuestions: correctQuestions ?? this.correctQuestions,
      timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
      targetRate: targetRate ?? this.targetRate,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (correctQuestions.present) {
      map['correct_questions'] = Variable<int>(correctQuestions.value);
    }
    if (timeSpentMinutes.present) {
      map['time_spent_minutes'] = Variable<int>(timeSpentMinutes.value);
    }
    if (targetRate.present) {
      map['target_rate'] = Variable<double>(targetRate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('module: $module, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctQuestions: $correctQuestions, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('targetRate: $targetRate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $EssayRecordsTable extends EssayRecords
    with TableInfo<$EssayRecordsTable, EssayRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EssayRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exam_records (id)'));
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
      'question_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _timeSpentMinutesMeta =
      const VerificationMeta('timeSpentMinutes');
  @override
  late final GeneratedColumn<int> timeSpentMinutes = GeneratedColumn<int>(
      'time_spent_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _problemMeta =
      const VerificationMeta('problem');
  @override
  late final GeneratedColumn<String> problem = GeneratedColumn<String>(
      'problem', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _improvementMeta =
      const VerificationMeta('improvement');
  @override
  late final GeneratedColumn<String> improvement = GeneratedColumn<String>(
      'improvement', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, examId, questionType, score, timeSpentMinutes, problem, improvement];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'essay_records';
  @override
  VerificationContext validateIntegrity(Insertable<EssayRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('time_spent_minutes')) {
      context.handle(
          _timeSpentMinutesMeta,
          timeSpentMinutes.isAcceptableOrUnknown(
              data['time_spent_minutes']!, _timeSpentMinutesMeta));
    }
    if (data.containsKey('problem')) {
      context.handle(_problemMeta,
          problem.isAcceptableOrUnknown(data['problem']!, _problemMeta));
    }
    if (data.containsKey('improvement')) {
      context.handle(
          _improvementMeta,
          improvement.isAcceptableOrUnknown(
              data['improvement']!, _improvementMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EssayRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EssayRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id'])!,
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_type'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score']),
      timeSpentMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}time_spent_minutes'])!,
      problem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}problem'])!,
      improvement: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}improvement'])!,
    );
  }

  @override
  $EssayRecordsTable createAlias(String alias) {
    return $EssayRecordsTable(attachedDatabase, alias);
  }
}

class EssayRecord extends DataClass implements Insertable<EssayRecord> {
  final int id;
  final int examId;
  final String questionType;
  final double? score;
  final int timeSpentMinutes;
  final String problem;
  final String improvement;
  const EssayRecord(
      {required this.id,
      required this.examId,
      required this.questionType,
      this.score,
      required this.timeSpentMinutes,
      required this.problem,
      required this.improvement});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exam_id'] = Variable<int>(examId);
    map['question_type'] = Variable<String>(questionType);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    map['time_spent_minutes'] = Variable<int>(timeSpentMinutes);
    map['problem'] = Variable<String>(problem);
    map['improvement'] = Variable<String>(improvement);
    return map;
  }

  EssayRecordsCompanion toCompanion(bool nullToAbsent) {
    return EssayRecordsCompanion(
      id: Value(id),
      examId: Value(examId),
      questionType: Value(questionType),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      timeSpentMinutes: Value(timeSpentMinutes),
      problem: Value(problem),
      improvement: Value(improvement),
    );
  }

  factory EssayRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EssayRecord(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int>(json['examId']),
      questionType: serializer.fromJson<String>(json['questionType']),
      score: serializer.fromJson<double?>(json['score']),
      timeSpentMinutes: serializer.fromJson<int>(json['timeSpentMinutes']),
      problem: serializer.fromJson<String>(json['problem']),
      improvement: serializer.fromJson<String>(json['improvement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int>(examId),
      'questionType': serializer.toJson<String>(questionType),
      'score': serializer.toJson<double?>(score),
      'timeSpentMinutes': serializer.toJson<int>(timeSpentMinutes),
      'problem': serializer.toJson<String>(problem),
      'improvement': serializer.toJson<String>(improvement),
    };
  }

  EssayRecord copyWith(
          {int? id,
          int? examId,
          String? questionType,
          Value<double?> score = const Value.absent(),
          int? timeSpentMinutes,
          String? problem,
          String? improvement}) =>
      EssayRecord(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        questionType: questionType ?? this.questionType,
        score: score.present ? score.value : this.score,
        timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
        problem: problem ?? this.problem,
        improvement: improvement ?? this.improvement,
      );
  EssayRecord copyWithCompanion(EssayRecordsCompanion data) {
    return EssayRecord(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      score: data.score.present ? data.score.value : this.score,
      timeSpentMinutes: data.timeSpentMinutes.present
          ? data.timeSpentMinutes.value
          : this.timeSpentMinutes,
      problem: data.problem.present ? data.problem.value : this.problem,
      improvement:
          data.improvement.present ? data.improvement.value : this.improvement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EssayRecord(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('questionType: $questionType, ')
          ..write('score: $score, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('problem: $problem, ')
          ..write('improvement: $improvement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, examId, questionType, score, timeSpentMinutes, problem, improvement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EssayRecord &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.questionType == this.questionType &&
          other.score == this.score &&
          other.timeSpentMinutes == this.timeSpentMinutes &&
          other.problem == this.problem &&
          other.improvement == this.improvement);
}

class EssayRecordsCompanion extends UpdateCompanion<EssayRecord> {
  final Value<int> id;
  final Value<int> examId;
  final Value<String> questionType;
  final Value<double?> score;
  final Value<int> timeSpentMinutes;
  final Value<String> problem;
  final Value<String> improvement;
  const EssayRecordsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.questionType = const Value.absent(),
    this.score = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.problem = const Value.absent(),
    this.improvement = const Value.absent(),
  });
  EssayRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int examId,
    required String questionType,
    this.score = const Value.absent(),
    this.timeSpentMinutes = const Value.absent(),
    this.problem = const Value.absent(),
    this.improvement = const Value.absent(),
  })  : examId = Value(examId),
        questionType = Value(questionType);
  static Insertable<EssayRecord> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<String>? questionType,
    Expression<double>? score,
    Expression<int>? timeSpentMinutes,
    Expression<String>? problem,
    Expression<String>? improvement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (questionType != null) 'question_type': questionType,
      if (score != null) 'score': score,
      if (timeSpentMinutes != null) 'time_spent_minutes': timeSpentMinutes,
      if (problem != null) 'problem': problem,
      if (improvement != null) 'improvement': improvement,
    });
  }

  EssayRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? examId,
      Value<String>? questionType,
      Value<double?>? score,
      Value<int>? timeSpentMinutes,
      Value<String>? problem,
      Value<String>? improvement}) {
    return EssayRecordsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      questionType: questionType ?? this.questionType,
      score: score ?? this.score,
      timeSpentMinutes: timeSpentMinutes ?? this.timeSpentMinutes,
      problem: problem ?? this.problem,
      improvement: improvement ?? this.improvement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (timeSpentMinutes.present) {
      map['time_spent_minutes'] = Variable<int>(timeSpentMinutes.value);
    }
    if (problem.present) {
      map['problem'] = Variable<String>(problem.value);
    }
    if (improvement.present) {
      map['improvement'] = Variable<String>(improvement.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EssayRecordsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('questionType: $questionType, ')
          ..write('score: $score, ')
          ..write('timeSpentMinutes: $timeSpentMinutes, ')
          ..write('problem: $problem, ')
          ..write('improvement: $improvement')
          ..write(')'))
        .toString();
  }
}

class $MistakesTable extends Mistakes with TableInfo<$MistakesTable, Mistake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exam_records (id)'));
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
      'module', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _knowledgePointMeta =
      const VerificationMeta('knowledgePoint');
  @override
  late final GeneratedColumn<String> knowledgePoint = GeneratedColumn<String>(
      'knowledge_point', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _myAnswerMeta =
      const VerificationMeta('myAnswer');
  @override
  late final GeneratedColumn<String> myAnswer = GeneratedColumn<String>(
      'my_answer', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _wrongReasonMeta =
      const VerificationMeta('wrongReason');
  @override
  late final GeneratedColumn<String> wrongReason = GeneratedColumn<String>(
      'wrong_reason', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('知识不会'));
  static const VerificationMeta _correctIdeaMeta =
      const VerificationMeta('correctIdea');
  @override
  late final GeneratedColumn<String> correctIdea = GeneratedColumn<String>(
      'correct_idea', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        module,
        knowledgePoint,
        question,
        myAnswer,
        correctAnswer,
        wrongReason,
        correctIdea,
        action,
        tags,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistakes';
  @override
  VerificationContext validateIntegrity(Insertable<Mistake> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    }
    if (data.containsKey('module')) {
      context.handle(_moduleMeta,
          module.isAcceptableOrUnknown(data['module']!, _moduleMeta));
    }
    if (data.containsKey('knowledge_point')) {
      context.handle(
          _knowledgePointMeta,
          knowledgePoint.isAcceptableOrUnknown(
              data['knowledge_point']!, _knowledgePointMeta));
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    }
    if (data.containsKey('my_answer')) {
      context.handle(_myAnswerMeta,
          myAnswer.isAcceptableOrUnknown(data['my_answer']!, _myAnswerMeta));
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    }
    if (data.containsKey('wrong_reason')) {
      context.handle(
          _wrongReasonMeta,
          wrongReason.isAcceptableOrUnknown(
              data['wrong_reason']!, _wrongReasonMeta));
    }
    if (data.containsKey('correct_idea')) {
      context.handle(
          _correctIdeaMeta,
          correctIdea.isAcceptableOrUnknown(
              data['correct_idea']!, _correctIdeaMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mistake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mistake(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id']),
      module: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}module'])!,
      knowledgePoint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}knowledge_point'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      myAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}my_answer'])!,
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer'])!,
      wrongReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wrong_reason'])!,
      correctIdea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_idea'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MistakesTable createAlias(String alias) {
    return $MistakesTable(attachedDatabase, alias);
  }
}

class Mistake extends DataClass implements Insertable<Mistake> {
  final int id;
  final int? examId;
  final String module;
  final String knowledgePoint;
  final String question;
  final String myAnswer;
  final String correctAnswer;
  final String wrongReason;
  final String correctIdea;
  final String action;
  final String tags;
  final DateTime createdAt;
  const Mistake(
      {required this.id,
      this.examId,
      required this.module,
      required this.knowledgePoint,
      required this.question,
      required this.myAnswer,
      required this.correctAnswer,
      required this.wrongReason,
      required this.correctIdea,
      required this.action,
      required this.tags,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || examId != null) {
      map['exam_id'] = Variable<int>(examId);
    }
    map['module'] = Variable<String>(module);
    map['knowledge_point'] = Variable<String>(knowledgePoint);
    map['question'] = Variable<String>(question);
    map['my_answer'] = Variable<String>(myAnswer);
    map['correct_answer'] = Variable<String>(correctAnswer);
    map['wrong_reason'] = Variable<String>(wrongReason);
    map['correct_idea'] = Variable<String>(correctIdea);
    map['action'] = Variable<String>(action);
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MistakesCompanion toCompanion(bool nullToAbsent) {
    return MistakesCompanion(
      id: Value(id),
      examId:
          examId == null && nullToAbsent ? const Value.absent() : Value(examId),
      module: Value(module),
      knowledgePoint: Value(knowledgePoint),
      question: Value(question),
      myAnswer: Value(myAnswer),
      correctAnswer: Value(correctAnswer),
      wrongReason: Value(wrongReason),
      correctIdea: Value(correctIdea),
      action: Value(action),
      tags: Value(tags),
      createdAt: Value(createdAt),
    );
  }

  factory Mistake.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mistake(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int?>(json['examId']),
      module: serializer.fromJson<String>(json['module']),
      knowledgePoint: serializer.fromJson<String>(json['knowledgePoint']),
      question: serializer.fromJson<String>(json['question']),
      myAnswer: serializer.fromJson<String>(json['myAnswer']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      wrongReason: serializer.fromJson<String>(json['wrongReason']),
      correctIdea: serializer.fromJson<String>(json['correctIdea']),
      action: serializer.fromJson<String>(json['action']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int?>(examId),
      'module': serializer.toJson<String>(module),
      'knowledgePoint': serializer.toJson<String>(knowledgePoint),
      'question': serializer.toJson<String>(question),
      'myAnswer': serializer.toJson<String>(myAnswer),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'wrongReason': serializer.toJson<String>(wrongReason),
      'correctIdea': serializer.toJson<String>(correctIdea),
      'action': serializer.toJson<String>(action),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Mistake copyWith(
          {int? id,
          Value<int?> examId = const Value.absent(),
          String? module,
          String? knowledgePoint,
          String? question,
          String? myAnswer,
          String? correctAnswer,
          String? wrongReason,
          String? correctIdea,
          String? action,
          String? tags,
          DateTime? createdAt}) =>
      Mistake(
        id: id ?? this.id,
        examId: examId.present ? examId.value : this.examId,
        module: module ?? this.module,
        knowledgePoint: knowledgePoint ?? this.knowledgePoint,
        question: question ?? this.question,
        myAnswer: myAnswer ?? this.myAnswer,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        wrongReason: wrongReason ?? this.wrongReason,
        correctIdea: correctIdea ?? this.correctIdea,
        action: action ?? this.action,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
      );
  Mistake copyWithCompanion(MistakesCompanion data) {
    return Mistake(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      module: data.module.present ? data.module.value : this.module,
      knowledgePoint: data.knowledgePoint.present
          ? data.knowledgePoint.value
          : this.knowledgePoint,
      question: data.question.present ? data.question.value : this.question,
      myAnswer: data.myAnswer.present ? data.myAnswer.value : this.myAnswer,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      wrongReason:
          data.wrongReason.present ? data.wrongReason.value : this.wrongReason,
      correctIdea:
          data.correctIdea.present ? data.correctIdea.value : this.correctIdea,
      action: data.action.present ? data.action.value : this.action,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mistake(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('module: $module, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('question: $question, ')
          ..write('myAnswer: $myAnswer, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongReason: $wrongReason, ')
          ..write('correctIdea: $correctIdea, ')
          ..write('action: $action, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      examId,
      module,
      knowledgePoint,
      question,
      myAnswer,
      correctAnswer,
      wrongReason,
      correctIdea,
      action,
      tags,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mistake &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.module == this.module &&
          other.knowledgePoint == this.knowledgePoint &&
          other.question == this.question &&
          other.myAnswer == this.myAnswer &&
          other.correctAnswer == this.correctAnswer &&
          other.wrongReason == this.wrongReason &&
          other.correctIdea == this.correctIdea &&
          other.action == this.action &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt);
}

class MistakesCompanion extends UpdateCompanion<Mistake> {
  final Value<int> id;
  final Value<int?> examId;
  final Value<String> module;
  final Value<String> knowledgePoint;
  final Value<String> question;
  final Value<String> myAnswer;
  final Value<String> correctAnswer;
  final Value<String> wrongReason;
  final Value<String> correctIdea;
  final Value<String> action;
  final Value<String> tags;
  final Value<DateTime> createdAt;
  const MistakesCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.module = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.question = const Value.absent(),
    this.myAnswer = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.wrongReason = const Value.absent(),
    this.correctIdea = const Value.absent(),
    this.action = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MistakesCompanion.insert({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.module = const Value.absent(),
    this.knowledgePoint = const Value.absent(),
    this.question = const Value.absent(),
    this.myAnswer = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.wrongReason = const Value.absent(),
    this.correctIdea = const Value.absent(),
    this.action = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Mistake> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<String>? module,
    Expression<String>? knowledgePoint,
    Expression<String>? question,
    Expression<String>? myAnswer,
    Expression<String>? correctAnswer,
    Expression<String>? wrongReason,
    Expression<String>? correctIdea,
    Expression<String>? action,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (module != null) 'module': module,
      if (knowledgePoint != null) 'knowledge_point': knowledgePoint,
      if (question != null) 'question': question,
      if (myAnswer != null) 'my_answer': myAnswer,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (wrongReason != null) 'wrong_reason': wrongReason,
      if (correctIdea != null) 'correct_idea': correctIdea,
      if (action != null) 'action': action,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MistakesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? examId,
      Value<String>? module,
      Value<String>? knowledgePoint,
      Value<String>? question,
      Value<String>? myAnswer,
      Value<String>? correctAnswer,
      Value<String>? wrongReason,
      Value<String>? correctIdea,
      Value<String>? action,
      Value<String>? tags,
      Value<DateTime>? createdAt}) {
    return MistakesCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      module: module ?? this.module,
      knowledgePoint: knowledgePoint ?? this.knowledgePoint,
      question: question ?? this.question,
      myAnswer: myAnswer ?? this.myAnswer,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongReason: wrongReason ?? this.wrongReason,
      correctIdea: correctIdea ?? this.correctIdea,
      action: action ?? this.action,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (knowledgePoint.present) {
      map['knowledge_point'] = Variable<String>(knowledgePoint.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (myAnswer.present) {
      map['my_answer'] = Variable<String>(myAnswer.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (wrongReason.present) {
      map['wrong_reason'] = Variable<String>(wrongReason.value);
    }
    if (correctIdea.present) {
      map['correct_idea'] = Variable<String>(correctIdea.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MistakesCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('module: $module, ')
          ..write('knowledgePoint: $knowledgePoint, ')
          ..write('question: $question, ')
          ..write('myAnswer: $myAnswer, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongReason: $wrongReason, ')
          ..write('correctIdea: $correctIdea, ')
          ..write('action: $action, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exam_records (id)'));
  static const VerificationMeta _keepMeta = const VerificationMeta('keep');
  @override
  late final GeneratedColumn<String> keep = GeneratedColumn<String>(
      'keep', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _problemMeta =
      const VerificationMeta('problem');
  @override
  late final GeneratedColumn<String> problem = GeneratedColumn<String>(
      'problem', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _attemptMeta =
      const VerificationMeta('attempt');
  @override
  late final GeneratedColumn<String> attempt = GeneratedColumn<String>(
      'attempt', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, examId, keep, problem, attempt, action, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('keep')) {
      context.handle(
          _keepMeta, keep.isAcceptableOrUnknown(data['keep']!, _keepMeta));
    }
    if (data.containsKey('problem')) {
      context.handle(_problemMeta,
          problem.isAcceptableOrUnknown(data['problem']!, _problemMeta));
    }
    if (data.containsKey('attempt')) {
      context.handle(_attemptMeta,
          attempt.isAcceptableOrUnknown(data['attempt']!, _attemptMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id'])!,
      keep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}keep'])!,
      problem: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}problem'])!,
      attempt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attempt'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final int id;
  final int examId;
  final String keep;
  final String problem;
  final String attempt;
  final String action;
  final DateTime createdAt;
  const Review(
      {required this.id,
      required this.examId,
      required this.keep,
      required this.problem,
      required this.attempt,
      required this.action,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exam_id'] = Variable<int>(examId);
    map['keep'] = Variable<String>(keep);
    map['problem'] = Variable<String>(problem);
    map['attempt'] = Variable<String>(attempt);
    map['action'] = Variable<String>(action);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      examId: Value(examId),
      keep: Value(keep),
      problem: Value(problem),
      attempt: Value(attempt),
      action: Value(action),
      createdAt: Value(createdAt),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int>(json['examId']),
      keep: serializer.fromJson<String>(json['keep']),
      problem: serializer.fromJson<String>(json['problem']),
      attempt: serializer.fromJson<String>(json['attempt']),
      action: serializer.fromJson<String>(json['action']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int>(examId),
      'keep': serializer.toJson<String>(keep),
      'problem': serializer.toJson<String>(problem),
      'attempt': serializer.toJson<String>(attempt),
      'action': serializer.toJson<String>(action),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Review copyWith(
          {int? id,
          int? examId,
          String? keep,
          String? problem,
          String? attempt,
          String? action,
          DateTime? createdAt}) =>
      Review(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        keep: keep ?? this.keep,
        problem: problem ?? this.problem,
        attempt: attempt ?? this.attempt,
        action: action ?? this.action,
        createdAt: createdAt ?? this.createdAt,
      );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      keep: data.keep.present ? data.keep.value : this.keep,
      problem: data.problem.present ? data.problem.value : this.problem,
      attempt: data.attempt.present ? data.attempt.value : this.attempt,
      action: data.action.present ? data.action.value : this.action,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('keep: $keep, ')
          ..write('problem: $problem, ')
          ..write('attempt: $attempt, ')
          ..write('action: $action, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, examId, keep, problem, attempt, action, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.keep == this.keep &&
          other.problem == this.problem &&
          other.attempt == this.attempt &&
          other.action == this.action &&
          other.createdAt == this.createdAt);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<int> id;
  final Value<int> examId;
  final Value<String> keep;
  final Value<String> problem;
  final Value<String> attempt;
  final Value<String> action;
  final Value<DateTime> createdAt;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.keep = const Value.absent(),
    this.problem = const Value.absent(),
    this.attempt = const Value.absent(),
    this.action = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int examId,
    this.keep = const Value.absent(),
    this.problem = const Value.absent(),
    this.attempt = const Value.absent(),
    this.action = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : examId = Value(examId);
  static Insertable<Review> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<String>? keep,
    Expression<String>? problem,
    Expression<String>? attempt,
    Expression<String>? action,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (keep != null) 'keep': keep,
      if (problem != null) 'problem': problem,
      if (attempt != null) 'attempt': attempt,
      if (action != null) 'action': action,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReviewsCompanion copyWith(
      {Value<int>? id,
      Value<int>? examId,
      Value<String>? keep,
      Value<String>? problem,
      Value<String>? attempt,
      Value<String>? action,
      Value<DateTime>? createdAt}) {
    return ReviewsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      keep: keep ?? this.keep,
      problem: problem ?? this.problem,
      attempt: attempt ?? this.attempt,
      action: action ?? this.action,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (keep.present) {
      map['keep'] = Variable<String>(keep.value);
    }
    if (problem.present) {
      map['problem'] = Variable<String>(problem.value);
    }
    if (attempt.present) {
      map['attempt'] = Variable<String>(attempt.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('keep: $keep, ')
          ..write('problem: $problem, ')
          ..write('attempt: $attempt, ')
          ..write('action: $action, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ActionItemsTable extends ActionItems
    with TableInfo<$ActionItemsTable, ActionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
      'owner', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('我'));
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('中'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('待办'));
  static const VerificationMeta _relatedExamIdMeta =
      const VerificationMeta('relatedExamId');
  @override
  late final GeneratedColumn<int> relatedExamId = GeneratedColumn<int>(
      'related_exam_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exam_records (id)'));
  static const VerificationMeta _relatedMistakeIdMeta =
      const VerificationMeta('relatedMistakeId');
  @override
  late final GeneratedColumn<int> relatedMistakeId = GeneratedColumn<int>(
      'related_mistake_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES mistakes (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        owner,
        dueDate,
        priority,
        status,
        relatedExamId,
        relatedMistakeId,
        createdAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'action_items';
  @override
  VerificationContext validateIntegrity(Insertable<ActionItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('related_exam_id')) {
      context.handle(
          _relatedExamIdMeta,
          relatedExamId.isAcceptableOrUnknown(
              data['related_exam_id']!, _relatedExamIdMeta));
    }
    if (data.containsKey('related_mistake_id')) {
      context.handle(
          _relatedMistakeIdMeta,
          relatedMistakeId.isAcceptableOrUnknown(
              data['related_mistake_id']!, _relatedMistakeIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActionItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      owner: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      relatedExamId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}related_exam_id']),
      relatedMistakeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}related_mistake_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $ActionItemsTable createAlias(String alias) {
    return $ActionItemsTable(attachedDatabase, alias);
  }
}

class ActionItem extends DataClass implements Insertable<ActionItem> {
  final int id;
  final String title;
  final String owner;
  final DateTime? dueDate;
  final String priority;
  final String status;
  final int? relatedExamId;
  final int? relatedMistakeId;
  final DateTime createdAt;
  final DateTime? completedAt;
  const ActionItem(
      {required this.id,
      required this.title,
      required this.owner,
      this.dueDate,
      required this.priority,
      required this.status,
      this.relatedExamId,
      this.relatedMistakeId,
      required this.createdAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['owner'] = Variable<String>(owner);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || relatedExamId != null) {
      map['related_exam_id'] = Variable<int>(relatedExamId);
    }
    if (!nullToAbsent || relatedMistakeId != null) {
      map['related_mistake_id'] = Variable<int>(relatedMistakeId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ActionItemsCompanion toCompanion(bool nullToAbsent) {
    return ActionItemsCompanion(
      id: Value(id),
      title: Value(title),
      owner: Value(owner),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      priority: Value(priority),
      status: Value(status),
      relatedExamId: relatedExamId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedExamId),
      relatedMistakeId: relatedMistakeId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedMistakeId),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ActionItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActionItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      owner: serializer.fromJson<String>(json['owner']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      relatedExamId: serializer.fromJson<int?>(json['relatedExamId']),
      relatedMistakeId: serializer.fromJson<int?>(json['relatedMistakeId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'owner': serializer.toJson<String>(owner),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'relatedExamId': serializer.toJson<int?>(relatedExamId),
      'relatedMistakeId': serializer.toJson<int?>(relatedMistakeId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ActionItem copyWith(
          {int? id,
          String? title,
          String? owner,
          Value<DateTime?> dueDate = const Value.absent(),
          String? priority,
          String? status,
          Value<int?> relatedExamId = const Value.absent(),
          Value<int?> relatedMistakeId = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      ActionItem(
        id: id ?? this.id,
        title: title ?? this.title,
        owner: owner ?? this.owner,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        priority: priority ?? this.priority,
        status: status ?? this.status,
        relatedExamId:
            relatedExamId.present ? relatedExamId.value : this.relatedExamId,
        relatedMistakeId: relatedMistakeId.present
            ? relatedMistakeId.value
            : this.relatedMistakeId,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  ActionItem copyWithCompanion(ActionItemsCompanion data) {
    return ActionItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      owner: data.owner.present ? data.owner.value : this.owner,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      relatedExamId: data.relatedExamId.present
          ? data.relatedExamId.value
          : this.relatedExamId,
      relatedMistakeId: data.relatedMistakeId.present
          ? data.relatedMistakeId.value
          : this.relatedMistakeId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActionItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('owner: $owner, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('relatedExamId: $relatedExamId, ')
          ..write('relatedMistakeId: $relatedMistakeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, owner, dueDate, priority, status,
      relatedExamId, relatedMistakeId, createdAt, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActionItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.owner == this.owner &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.relatedExamId == this.relatedExamId &&
          other.relatedMistakeId == this.relatedMistakeId &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class ActionItemsCompanion extends UpdateCompanion<ActionItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> owner;
  final Value<DateTime?> dueDate;
  final Value<String> priority;
  final Value<String> status;
  final Value<int?> relatedExamId;
  final Value<int?> relatedMistakeId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  const ActionItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.owner = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.relatedExamId = const Value.absent(),
    this.relatedMistakeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  ActionItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.owner = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.relatedExamId = const Value.absent(),
    this.relatedMistakeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<ActionItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? owner,
    Expression<DateTime>? dueDate,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<int>? relatedExamId,
    Expression<int>? relatedMistakeId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (owner != null) 'owner': owner,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (relatedExamId != null) 'related_exam_id': relatedExamId,
      if (relatedMistakeId != null) 'related_mistake_id': relatedMistakeId,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  ActionItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? owner,
      Value<DateTime?>? dueDate,
      Value<String>? priority,
      Value<String>? status,
      Value<int?>? relatedExamId,
      Value<int?>? relatedMistakeId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? completedAt}) {
    return ActionItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      relatedExamId: relatedExamId ?? this.relatedExamId,
      relatedMistakeId: relatedMistakeId ?? this.relatedMistakeId,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (relatedExamId.present) {
      map['related_exam_id'] = Variable<int>(relatedExamId.value);
    }
    if (relatedMistakeId.present) {
      map['related_mistake_id'] = Variable<int>(relatedMistakeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActionItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('owner: $owner, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('relatedExamId: $relatedExamId, ')
          ..write('relatedMistakeId: $relatedMistakeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeCardsTable extends KnowledgeCards
    with TableInfo<$KnowledgeCardsTable, KnowledgeCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _cardTypeMeta =
      const VerificationMeta('cardType');
  @override
  late final GeneratedColumn<String> cardType = GeneratedColumn<String>(
      'card_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('经验卡片'));
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _favoriteMeta =
      const VerificationMeta('favorite');
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
      'favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, cardType, tags, favorite, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_cards';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('card_type')) {
      context.handle(_cardTypeMeta,
          cardType.isAcceptableOrUnknown(data['card_type']!, _cardTypeMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('favorite')) {
      context.handle(_favoriteMeta,
          favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      cardType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_type'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      favorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}favorite'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KnowledgeCardsTable createAlias(String alias) {
    return $KnowledgeCardsTable(attachedDatabase, alias);
  }
}

class KnowledgeCard extends DataClass implements Insertable<KnowledgeCard> {
  final int id;
  final String title;
  final String content;
  final String cardType;
  final String tags;
  final bool favorite;
  final DateTime createdAt;
  const KnowledgeCard(
      {required this.id,
      required this.title,
      required this.content,
      required this.cardType,
      required this.tags,
      required this.favorite,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['card_type'] = Variable<String>(cardType);
    map['tags'] = Variable<String>(tags);
    map['favorite'] = Variable<bool>(favorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnowledgeCardsCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeCardsCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      cardType: Value(cardType),
      tags: Value(tags),
      favorite: Value(favorite),
      createdAt: Value(createdAt),
    );
  }

  factory KnowledgeCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeCard(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      cardType: serializer.fromJson<String>(json['cardType']),
      tags: serializer.fromJson<String>(json['tags']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'cardType': serializer.toJson<String>(cardType),
      'tags': serializer.toJson<String>(tags),
      'favorite': serializer.toJson<bool>(favorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnowledgeCard copyWith(
          {int? id,
          String? title,
          String? content,
          String? cardType,
          String? tags,
          bool? favorite,
          DateTime? createdAt}) =>
      KnowledgeCard(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        cardType: cardType ?? this.cardType,
        tags: tags ?? this.tags,
        favorite: favorite ?? this.favorite,
        createdAt: createdAt ?? this.createdAt,
      );
  KnowledgeCard copyWithCompanion(KnowledgeCardsCompanion data) {
    return KnowledgeCard(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      cardType: data.cardType.present ? data.cardType.value : this.cardType,
      tags: data.tags.present ? data.tags.value : this.tags,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeCard(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('cardType: $cardType, ')
          ..write('tags: $tags, ')
          ..write('favorite: $favorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, cardType, tags, favorite, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeCard &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.cardType == this.cardType &&
          other.tags == this.tags &&
          other.favorite == this.favorite &&
          other.createdAt == this.createdAt);
}

class KnowledgeCardsCompanion extends UpdateCompanion<KnowledgeCard> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> cardType;
  final Value<String> tags;
  final Value<bool> favorite;
  final Value<DateTime> createdAt;
  const KnowledgeCardsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.cardType = const Value.absent(),
    this.tags = const Value.absent(),
    this.favorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KnowledgeCardsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.content = const Value.absent(),
    this.cardType = const Value.absent(),
    this.tags = const Value.absent(),
    this.favorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<KnowledgeCard> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? cardType,
    Expression<String>? tags,
    Expression<bool>? favorite,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (cardType != null) 'card_type': cardType,
      if (tags != null) 'tags': tags,
      if (favorite != null) 'favorite': favorite,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  KnowledgeCardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? cardType,
      Value<String>? tags,
      Value<bool>? favorite,
      Value<DateTime>? createdAt}) {
    return KnowledgeCardsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      cardType: cardType ?? this.cardType,
      tags: tags ?? this.tags,
      favorite: favorite ?? this.favorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (cardType.present) {
      map['card_type'] = Variable<String>(cardType.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeCardsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('cardType: $cardType, ')
          ..write('tags: $tags, ')
          ..write('favorite: $favorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExamRecordsTable examRecords = $ExamRecordsTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $EssayRecordsTable essayRecords = $EssayRecordsTable(this);
  late final $MistakesTable mistakes = $MistakesTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $ActionItemsTable actionItems = $ActionItemsTable(this);
  late final $KnowledgeCardsTable knowledgeCards = $KnowledgeCardsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        examRecords,
        sections,
        essayRecords,
        mistakes,
        reviews,
        actionItems,
        knowledgeCards
      ];
}

typedef $$ExamRecordsTableCreateCompanionBuilder = ExamRecordsCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String> type,
  required DateTime date,
  Value<int> durationMinutes,
  Value<double?> totalScore,
  Value<String> note,
});
typedef $$ExamRecordsTableUpdateCompanionBuilder = ExamRecordsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<DateTime> date,
  Value<int> durationMinutes,
  Value<double?> totalScore,
  Value<String> note,
});

final class $$ExamRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamRecordsTable, ExamRecord> {
  $$ExamRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SectionsTable, List<Section>> _sectionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sections,
          aliasName: 'exam_records__id__sections__exam_id');

  $$SectionsTableProcessedTableManager get sectionsRefs {
    final manager = $$SectionsTableTableManager($_db, $_db.sections)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EssayRecordsTable, List<EssayRecord>>
      _essayRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.essayRecords,
              aliasName: 'exam_records__id__essay_records__exam_id');

  $$EssayRecordsTableProcessedTableManager get essayRecordsRefs {
    final manager = $$EssayRecordsTableTableManager($_db, $_db.essayRecords)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_essayRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MistakesTable, List<Mistake>> _mistakesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.mistakes,
          aliasName: 'exam_records__id__mistakes__exam_id');

  $$MistakesTableProcessedTableManager get mistakesRefs {
    final manager = $$MistakesTableTableManager($_db, $_db.mistakes)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mistakesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReviewsTable, List<Review>> _reviewsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.reviews,
          aliasName: 'exam_records__id__reviews__exam_id');

  $$ReviewsTableProcessedTableManager get reviewsRefs {
    final manager = $$ReviewsTableTableManager($_db, $_db.reviews)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ActionItemsTable, List<ActionItem>>
      _actionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.actionItems,
              aliasName: 'exam_records__id__action_items__related_exam_id');

  $$ActionItemsTableProcessedTableManager get actionItemsRefs {
    final manager = $$ActionItemsTableTableManager($_db, $_db.actionItems)
        .filter((f) => f.relatedExamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_actionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExamRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamRecordsTable> {
  $$ExamRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  Expression<bool> sectionsRefs(
      Expression<bool> Function($$SectionsTableFilterComposer f) f) {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableFilterComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> essayRecordsRefs(
      Expression<bool> Function($$EssayRecordsTableFilterComposer f) f) {
    final $$EssayRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.essayRecords,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EssayRecordsTableFilterComposer(
              $db: $db,
              $table: $db.essayRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mistakesRefs(
      Expression<bool> Function($$MistakesTableFilterComposer f) f) {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableFilterComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> reviewsRefs(
      Expression<bool> Function($$ReviewsTableFilterComposer f) f) {
    final $$ReviewsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviews,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewsTableFilterComposer(
              $db: $db,
              $table: $db.reviews,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> actionItemsRefs(
      Expression<bool> Function($$ActionItemsTableFilterComposer f) f) {
    final $$ActionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actionItems,
        getReferencedColumn: (t) => t.relatedExamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActionItemsTableFilterComposer(
              $db: $db,
              $table: $db.actionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamRecordsTable> {
  $$ExamRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$ExamRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamRecordsTable> {
  $$ExamRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<double> get totalScore => $composableBuilder(
      column: $table.totalScore, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> sectionsRefs<T extends Object>(
      Expression<T> Function($$SectionsTableAnnotationComposer a) f) {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> essayRecordsRefs<T extends Object>(
      Expression<T> Function($$EssayRecordsTableAnnotationComposer a) f) {
    final $$EssayRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.essayRecords,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EssayRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.essayRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> mistakesRefs<T extends Object>(
      Expression<T> Function($$MistakesTableAnnotationComposer a) f) {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> reviewsRefs<T extends Object>(
      Expression<T> Function($$ReviewsTableAnnotationComposer a) f) {
    final $$ReviewsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviews,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewsTableAnnotationComposer(
              $db: $db,
              $table: $db.reviews,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> actionItemsRefs<T extends Object>(
      Expression<T> Function($$ActionItemsTableAnnotationComposer a) f) {
    final $$ActionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actionItems,
        getReferencedColumn: (t) => t.relatedExamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.actionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamRecordsTable,
    ExamRecord,
    $$ExamRecordsTableFilterComposer,
    $$ExamRecordsTableOrderingComposer,
    $$ExamRecordsTableAnnotationComposer,
    $$ExamRecordsTableCreateCompanionBuilder,
    $$ExamRecordsTableUpdateCompanionBuilder,
    (ExamRecord, $$ExamRecordsTableReferences),
    ExamRecord,
    PrefetchHooks Function(
        {bool sectionsRefs,
        bool essayRecordsRefs,
        bool mistakesRefs,
        bool reviewsRefs,
        bool actionItemsRefs})> {
  $$ExamRecordsTableTableManager(_$AppDatabase db, $ExamRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<double?> totalScore = const Value.absent(),
            Value<String> note = const Value.absent(),
          }) =>
              ExamRecordsCompanion(
            id: id,
            name: name,
            type: type,
            date: date,
            durationMinutes: durationMinutes,
            totalScore: totalScore,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> type = const Value.absent(),
            required DateTime date,
            Value<int> durationMinutes = const Value.absent(),
            Value<double?> totalScore = const Value.absent(),
            Value<String> note = const Value.absent(),
          }) =>
              ExamRecordsCompanion.insert(
            id: id,
            name: name,
            type: type,
            date: date,
            durationMinutes: durationMinutes,
            totalScore: totalScore,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ExamRecordsTable, ExamRecord>(table),
                    $$ExamRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {sectionsRefs = false,
              essayRecordsRefs = false,
              mistakesRefs = false,
              reviewsRefs = false,
              actionItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionsRefs) db.sections,
                if (essayRecordsRefs) db.essayRecords,
                if (mistakesRefs) db.mistakes,
                if (reviewsRefs) db.reviews,
                if (actionItemsRefs) db.actionItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionsRefs)
                    await $_getPrefetchedData<ExamRecord, $ExamRecordsTable,
                            Section>(
                        currentTable: table,
                        referencedTable:
                            $$ExamRecordsTableReferences._sectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamRecordsTableReferences(db, table, p0)
                                .sectionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (essayRecordsRefs)
                    await $_getPrefetchedData<ExamRecord, $ExamRecordsTable,
                            EssayRecord>(
                        currentTable: table,
                        referencedTable: $$ExamRecordsTableReferences
                            ._essayRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamRecordsTableReferences(db, table, p0)
                                .essayRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (mistakesRefs)
                    await $_getPrefetchedData<ExamRecord, $ExamRecordsTable,
                            Mistake>(
                        currentTable: table,
                        referencedTable:
                            $$ExamRecordsTableReferences._mistakesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamRecordsTableReferences(db, table, p0)
                                .mistakesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (reviewsRefs)
                    await $_getPrefetchedData<ExamRecord, $ExamRecordsTable,
                            Review>(
                        currentTable: table,
                        referencedTable:
                            $$ExamRecordsTableReferences._reviewsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamRecordsTableReferences(db, table, p0)
                                .reviewsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (actionItemsRefs)
                    await $_getPrefetchedData<ExamRecord, $ExamRecordsTable,
                            ActionItem>(
                        currentTable: table,
                        referencedTable: $$ExamRecordsTableReferences
                            ._actionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamRecordsTableReferences(db, table, p0)
                                .actionItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relatedExamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExamRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamRecordsTable,
    ExamRecord,
    $$ExamRecordsTableFilterComposer,
    $$ExamRecordsTableOrderingComposer,
    $$ExamRecordsTableAnnotationComposer,
    $$ExamRecordsTableCreateCompanionBuilder,
    $$ExamRecordsTableUpdateCompanionBuilder,
    (ExamRecord, $$ExamRecordsTableReferences),
    ExamRecord,
    PrefetchHooks Function(
        {bool sectionsRefs,
        bool essayRecordsRefs,
        bool mistakesRefs,
        bool reviewsRefs,
        bool actionItemsRefs})>;
typedef $$SectionsTableCreateCompanionBuilder = SectionsCompanion Function({
  Value<int> id,
  required int examId,
  required String module,
  Value<int> totalQuestions,
  Value<int> correctQuestions,
  Value<int> timeSpentMinutes,
  Value<double?> targetRate,
  Value<String> note,
});
typedef $$SectionsTableUpdateCompanionBuilder = SectionsCompanion Function({
  Value<int> id,
  Value<int> examId,
  Value<String> module,
  Value<int> totalQuestions,
  Value<int> correctQuestions,
  Value<int> timeSpentMinutes,
  Value<double?> targetRate,
  Value<String> note,
});

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, Section> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamRecordsTable _examIdTable(_$AppDatabase db) =>
      db.examRecords.createAlias('sections__exam_id__exam_records__id');

  $$ExamRecordsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<int>('exam_id')!;

    final manager = $$ExamRecordsTableTableManager($_db, $_db.examRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctQuestions => $composableBuilder(
      column: $table.correctQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetRate => $composableBuilder(
      column: $table.targetRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$ExamRecordsTableFilterComposer get examId {
    final $$ExamRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableFilterComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctQuestions => $composableBuilder(
      column: $table.correctQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetRate => $composableBuilder(
      column: $table.targetRate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$ExamRecordsTableOrderingComposer get examId {
    final $$ExamRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions, builder: (column) => column);

  GeneratedColumn<int> get correctQuestions => $composableBuilder(
      column: $table.correctQuestions, builder: (column) => column);

  GeneratedColumn<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes, builder: (column) => column);

  GeneratedColumn<double> get targetRate => $composableBuilder(
      column: $table.targetRate, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ExamRecordsTableAnnotationComposer get examId {
    final $$ExamRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SectionsTable,
    Section,
    $$SectionsTableFilterComposer,
    $$SectionsTableOrderingComposer,
    $$SectionsTableAnnotationComposer,
    $$SectionsTableCreateCompanionBuilder,
    $$SectionsTableUpdateCompanionBuilder,
    (Section, $$SectionsTableReferences),
    Section,
    PrefetchHooks Function({bool examId})> {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> examId = const Value.absent(),
            Value<String> module = const Value.absent(),
            Value<int> totalQuestions = const Value.absent(),
            Value<int> correctQuestions = const Value.absent(),
            Value<int> timeSpentMinutes = const Value.absent(),
            Value<double?> targetRate = const Value.absent(),
            Value<String> note = const Value.absent(),
          }) =>
              SectionsCompanion(
            id: id,
            examId: examId,
            module: module,
            totalQuestions: totalQuestions,
            correctQuestions: correctQuestions,
            timeSpentMinutes: timeSpentMinutes,
            targetRate: targetRate,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int examId,
            required String module,
            Value<int> totalQuestions = const Value.absent(),
            Value<int> correctQuestions = const Value.absent(),
            Value<int> timeSpentMinutes = const Value.absent(),
            Value<double?> targetRate = const Value.absent(),
            Value<String> note = const Value.absent(),
          }) =>
              SectionsCompanion.insert(
            id: id,
            examId: examId,
            module: module,
            totalQuestions: totalQuestions,
            correctQuestions: correctQuestions,
            timeSpentMinutes: timeSpentMinutes,
            targetRate: targetRate,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SectionsTable, Section>(table),
                    $$SectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable: $$SectionsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$SectionsTableReferences._examIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SectionsTable,
    Section,
    $$SectionsTableFilterComposer,
    $$SectionsTableOrderingComposer,
    $$SectionsTableAnnotationComposer,
    $$SectionsTableCreateCompanionBuilder,
    $$SectionsTableUpdateCompanionBuilder,
    (Section, $$SectionsTableReferences),
    Section,
    PrefetchHooks Function({bool examId})>;
typedef $$EssayRecordsTableCreateCompanionBuilder = EssayRecordsCompanion
    Function({
  Value<int> id,
  required int examId,
  required String questionType,
  Value<double?> score,
  Value<int> timeSpentMinutes,
  Value<String> problem,
  Value<String> improvement,
});
typedef $$EssayRecordsTableUpdateCompanionBuilder = EssayRecordsCompanion
    Function({
  Value<int> id,
  Value<int> examId,
  Value<String> questionType,
  Value<double?> score,
  Value<int> timeSpentMinutes,
  Value<String> problem,
  Value<String> improvement,
});

final class $$EssayRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $EssayRecordsTable, EssayRecord> {
  $$EssayRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamRecordsTable _examIdTable(_$AppDatabase db) =>
      db.examRecords.createAlias('essay_records__exam_id__exam_records__id');

  $$ExamRecordsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<int>('exam_id')!;

    final manager = $$ExamRecordsTableTableManager($_db, $_db.examRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EssayRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $EssayRecordsTable> {
  $$EssayRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get problem => $composableBuilder(
      column: $table.problem, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get improvement => $composableBuilder(
      column: $table.improvement, builder: (column) => ColumnFilters(column));

  $$ExamRecordsTableFilterComposer get examId {
    final $$ExamRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableFilterComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EssayRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $EssayRecordsTable> {
  $$EssayRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionType => $composableBuilder(
      column: $table.questionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get problem => $composableBuilder(
      column: $table.problem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get improvement => $composableBuilder(
      column: $table.improvement, builder: (column) => ColumnOrderings(column));

  $$ExamRecordsTableOrderingComposer get examId {
    final $$ExamRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EssayRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EssayRecordsTable> {
  $$EssayRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionType => $composableBuilder(
      column: $table.questionType, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get timeSpentMinutes => $composableBuilder(
      column: $table.timeSpentMinutes, builder: (column) => column);

  GeneratedColumn<String> get problem =>
      $composableBuilder(column: $table.problem, builder: (column) => column);

  GeneratedColumn<String> get improvement => $composableBuilder(
      column: $table.improvement, builder: (column) => column);

  $$ExamRecordsTableAnnotationComposer get examId {
    final $$ExamRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EssayRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EssayRecordsTable,
    EssayRecord,
    $$EssayRecordsTableFilterComposer,
    $$EssayRecordsTableOrderingComposer,
    $$EssayRecordsTableAnnotationComposer,
    $$EssayRecordsTableCreateCompanionBuilder,
    $$EssayRecordsTableUpdateCompanionBuilder,
    (EssayRecord, $$EssayRecordsTableReferences),
    EssayRecord,
    PrefetchHooks Function({bool examId})> {
  $$EssayRecordsTableTableManager(_$AppDatabase db, $EssayRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EssayRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EssayRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EssayRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> examId = const Value.absent(),
            Value<String> questionType = const Value.absent(),
            Value<double?> score = const Value.absent(),
            Value<int> timeSpentMinutes = const Value.absent(),
            Value<String> problem = const Value.absent(),
            Value<String> improvement = const Value.absent(),
          }) =>
              EssayRecordsCompanion(
            id: id,
            examId: examId,
            questionType: questionType,
            score: score,
            timeSpentMinutes: timeSpentMinutes,
            problem: problem,
            improvement: improvement,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int examId,
            required String questionType,
            Value<double?> score = const Value.absent(),
            Value<int> timeSpentMinutes = const Value.absent(),
            Value<String> problem = const Value.absent(),
            Value<String> improvement = const Value.absent(),
          }) =>
              EssayRecordsCompanion.insert(
            id: id,
            examId: examId,
            questionType: questionType,
            score: score,
            timeSpentMinutes: timeSpentMinutes,
            problem: problem,
            improvement: improvement,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$EssayRecordsTable, EssayRecord>(table),
                    $$EssayRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$EssayRecordsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$EssayRecordsTableReferences._examIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EssayRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EssayRecordsTable,
    EssayRecord,
    $$EssayRecordsTableFilterComposer,
    $$EssayRecordsTableOrderingComposer,
    $$EssayRecordsTableAnnotationComposer,
    $$EssayRecordsTableCreateCompanionBuilder,
    $$EssayRecordsTableUpdateCompanionBuilder,
    (EssayRecord, $$EssayRecordsTableReferences),
    EssayRecord,
    PrefetchHooks Function({bool examId})>;
typedef $$MistakesTableCreateCompanionBuilder = MistakesCompanion Function({
  Value<int> id,
  Value<int?> examId,
  Value<String> module,
  Value<String> knowledgePoint,
  Value<String> question,
  Value<String> myAnswer,
  Value<String> correctAnswer,
  Value<String> wrongReason,
  Value<String> correctIdea,
  Value<String> action,
  Value<String> tags,
  Value<DateTime> createdAt,
});
typedef $$MistakesTableUpdateCompanionBuilder = MistakesCompanion Function({
  Value<int> id,
  Value<int?> examId,
  Value<String> module,
  Value<String> knowledgePoint,
  Value<String> question,
  Value<String> myAnswer,
  Value<String> correctAnswer,
  Value<String> wrongReason,
  Value<String> correctIdea,
  Value<String> action,
  Value<String> tags,
  Value<DateTime> createdAt,
});

final class $$MistakesTableReferences
    extends BaseReferences<_$AppDatabase, $MistakesTable, Mistake> {
  $$MistakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamRecordsTable _examIdTable(_$AppDatabase db) =>
      db.examRecords.createAlias('mistakes__exam_id__exam_records__id');

  $$ExamRecordsTableProcessedTableManager? get examId {
    final $_column = $_itemColumn<int>('exam_id');
    if ($_column == null) return null;
    final manager = $$ExamRecordsTableTableManager($_db, $_db.examRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ActionItemsTable, List<ActionItem>>
      _actionItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.actionItems,
              aliasName: 'mistakes__id__action_items__related_mistake_id');

  $$ActionItemsTableProcessedTableManager get actionItemsRefs {
    final manager = $$ActionItemsTableTableManager($_db, $_db.actionItems)
        .filter(
            (f) => f.relatedMistakeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_actionItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MistakesTableFilterComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get myAnswer => $composableBuilder(
      column: $table.myAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wrongReason => $composableBuilder(
      column: $table.wrongReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctIdea => $composableBuilder(
      column: $table.correctIdea, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ExamRecordsTableFilterComposer get examId {
    final $$ExamRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableFilterComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> actionItemsRefs(
      Expression<bool> Function($$ActionItemsTableFilterComposer f) f) {
    final $$ActionItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actionItems,
        getReferencedColumn: (t) => t.relatedMistakeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActionItemsTableFilterComposer(
              $db: $db,
              $table: $db.actionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MistakesTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get myAnswer => $composableBuilder(
      column: $table.myAnswer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wrongReason => $composableBuilder(
      column: $table.wrongReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctIdea => $composableBuilder(
      column: $table.correctIdea, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ExamRecordsTableOrderingComposer get examId {
    final $$ExamRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakesTable> {
  $$MistakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<String> get knowledgePoint => $composableBuilder(
      column: $table.knowledgePoint, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get myAnswer =>
      $composableBuilder(column: $table.myAnswer, builder: (column) => column);

  GeneratedColumn<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => column);

  GeneratedColumn<String> get wrongReason => $composableBuilder(
      column: $table.wrongReason, builder: (column) => column);

  GeneratedColumn<String> get correctIdea => $composableBuilder(
      column: $table.correctIdea, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExamRecordsTableAnnotationComposer get examId {
    final $$ExamRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> actionItemsRefs<T extends Object>(
      Expression<T> Function($$ActionItemsTableAnnotationComposer a) f) {
    final $$ActionItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actionItems,
        getReferencedColumn: (t) => t.relatedMistakeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActionItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.actionItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MistakesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MistakesTable,
    Mistake,
    $$MistakesTableFilterComposer,
    $$MistakesTableOrderingComposer,
    $$MistakesTableAnnotationComposer,
    $$MistakesTableCreateCompanionBuilder,
    $$MistakesTableUpdateCompanionBuilder,
    (Mistake, $$MistakesTableReferences),
    Mistake,
    PrefetchHooks Function({bool examId, bool actionItemsRefs})> {
  $$MistakesTableTableManager(_$AppDatabase db, $MistakesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> examId = const Value.absent(),
            Value<String> module = const Value.absent(),
            Value<String> knowledgePoint = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> myAnswer = const Value.absent(),
            Value<String> correctAnswer = const Value.absent(),
            Value<String> wrongReason = const Value.absent(),
            Value<String> correctIdea = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MistakesCompanion(
            id: id,
            examId: examId,
            module: module,
            knowledgePoint: knowledgePoint,
            question: question,
            myAnswer: myAnswer,
            correctAnswer: correctAnswer,
            wrongReason: wrongReason,
            correctIdea: correctIdea,
            action: action,
            tags: tags,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> examId = const Value.absent(),
            Value<String> module = const Value.absent(),
            Value<String> knowledgePoint = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> myAnswer = const Value.absent(),
            Value<String> correctAnswer = const Value.absent(),
            Value<String> wrongReason = const Value.absent(),
            Value<String> correctIdea = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MistakesCompanion.insert(
            id: id,
            examId: examId,
            module: module,
            knowledgePoint: knowledgePoint,
            question: question,
            myAnswer: myAnswer,
            correctAnswer: correctAnswer,
            wrongReason: wrongReason,
            correctIdea: correctIdea,
            action: action,
            tags: tags,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$MistakesTable, Mistake>(table),
                    $$MistakesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false, actionItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (actionItemsRefs) db.actionItems],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable: $$MistakesTableReferences._examIdTable(db),
                    referencedColumn:
                        $$MistakesTableReferences._examIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (actionItemsRefs)
                    await $_getPrefetchedData<Mistake, $MistakesTable,
                            ActionItem>(
                        currentTable: table,
                        referencedTable:
                            $$MistakesTableReferences._actionItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MistakesTableReferences(db, table, p0)
                                .actionItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.relatedMistakeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MistakesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MistakesTable,
    Mistake,
    $$MistakesTableFilterComposer,
    $$MistakesTableOrderingComposer,
    $$MistakesTableAnnotationComposer,
    $$MistakesTableCreateCompanionBuilder,
    $$MistakesTableUpdateCompanionBuilder,
    (Mistake, $$MistakesTableReferences),
    Mistake,
    PrefetchHooks Function({bool examId, bool actionItemsRefs})>;
typedef $$ReviewsTableCreateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  required int examId,
  Value<String> keep,
  Value<String> problem,
  Value<String> attempt,
  Value<String> action,
  Value<DateTime> createdAt,
});
typedef $$ReviewsTableUpdateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  Value<int> examId,
  Value<String> keep,
  Value<String> problem,
  Value<String> attempt,
  Value<String> action,
  Value<DateTime> createdAt,
});

final class $$ReviewsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewsTable, Review> {
  $$ReviewsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamRecordsTable _examIdTable(_$AppDatabase db) =>
      db.examRecords.createAlias('reviews__exam_id__exam_records__id');

  $$ExamRecordsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<int>('exam_id')!;

    final manager = $$ExamRecordsTableTableManager($_db, $_db.examRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keep => $composableBuilder(
      column: $table.keep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get problem => $composableBuilder(
      column: $table.problem, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attempt => $composableBuilder(
      column: $table.attempt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ExamRecordsTableFilterComposer get examId {
    final $$ExamRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableFilterComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keep => $composableBuilder(
      column: $table.keep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get problem => $composableBuilder(
      column: $table.problem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attempt => $composableBuilder(
      column: $table.attempt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ExamRecordsTableOrderingComposer get examId {
    final $$ExamRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get keep =>
      $composableBuilder(column: $table.keep, builder: (column) => column);

  GeneratedColumn<String> get problem =>
      $composableBuilder(column: $table.problem, builder: (column) => column);

  GeneratedColumn<String> get attempt =>
      $composableBuilder(column: $table.attempt, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExamRecordsTableAnnotationComposer get examId {
    final $$ExamRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, $$ReviewsTableReferences),
    Review,
    PrefetchHooks Function({bool examId})> {
  $$ReviewsTableTableManager(_$AppDatabase db, $ReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> examId = const Value.absent(),
            Value<String> keep = const Value.absent(),
            Value<String> problem = const Value.absent(),
            Value<String> attempt = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ReviewsCompanion(
            id: id,
            examId: examId,
            keep: keep,
            problem: problem,
            attempt: attempt,
            action: action,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int examId,
            Value<String> keep = const Value.absent(),
            Value<String> problem = const Value.absent(),
            Value<String> attempt = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ReviewsCompanion.insert(
            id: id,
            examId: examId,
            keep: keep,
            problem: problem,
            attempt: attempt,
            action: action,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ReviewsTable, Review>(table),
                    $$ReviewsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable: $$ReviewsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$ReviewsTableReferences._examIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, $$ReviewsTableReferences),
    Review,
    PrefetchHooks Function({bool examId})>;
typedef $$ActionItemsTableCreateCompanionBuilder = ActionItemsCompanion
    Function({
  Value<int> id,
  required String title,
  Value<String> owner,
  Value<DateTime?> dueDate,
  Value<String> priority,
  Value<String> status,
  Value<int?> relatedExamId,
  Value<int?> relatedMistakeId,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
});
typedef $$ActionItemsTableUpdateCompanionBuilder = ActionItemsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> owner,
  Value<DateTime?> dueDate,
  Value<String> priority,
  Value<String> status,
  Value<int?> relatedExamId,
  Value<int?> relatedMistakeId,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
});

final class $$ActionItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ActionItemsTable, ActionItem> {
  $$ActionItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamRecordsTable _relatedExamIdTable(_$AppDatabase db) =>
      db.examRecords
          .createAlias('action_items__related_exam_id__exam_records__id');

  $$ExamRecordsTableProcessedTableManager? get relatedExamId {
    final $_column = $_itemColumn<int>('related_exam_id');
    if ($_column == null) return null;
    final manager = $$ExamRecordsTableTableManager($_db, $_db.examRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedExamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MistakesTable _relatedMistakeIdTable(_$AppDatabase db) =>
      db.mistakes.createAlias('action_items__related_mistake_id__mistakes__id');

  $$MistakesTableProcessedTableManager? get relatedMistakeId {
    final $_column = $_itemColumn<int>('related_mistake_id');
    if ($_column == null) return null;
    final manager = $$MistakesTableTableManager($_db, $_db.mistakes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedMistakeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ActionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ActionItemsTable> {
  $$ActionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get owner => $composableBuilder(
      column: $table.owner, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  $$ExamRecordsTableFilterComposer get relatedExamId {
    final $$ExamRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedExamId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableFilterComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MistakesTableFilterComposer get relatedMistakeId {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedMistakeId,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableFilterComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActionItemsTable> {
  $$ActionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get owner => $composableBuilder(
      column: $table.owner, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  $$ExamRecordsTableOrderingComposer get relatedExamId {
    final $$ExamRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedExamId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MistakesTableOrderingComposer get relatedMistakeId {
    final $$MistakesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedMistakeId,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableOrderingComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActionItemsTable> {
  $$ActionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  $$ExamRecordsTableAnnotationComposer get relatedExamId {
    final $$ExamRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedExamId,
        referencedTable: $db.examRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.examRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MistakesTableAnnotationComposer get relatedMistakeId {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.relatedMistakeId,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActionItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActionItemsTable,
    ActionItem,
    $$ActionItemsTableFilterComposer,
    $$ActionItemsTableOrderingComposer,
    $$ActionItemsTableAnnotationComposer,
    $$ActionItemsTableCreateCompanionBuilder,
    $$ActionItemsTableUpdateCompanionBuilder,
    (ActionItem, $$ActionItemsTableReferences),
    ActionItem,
    PrefetchHooks Function({bool relatedExamId, bool relatedMistakeId})> {
  $$ActionItemsTableTableManager(_$AppDatabase db, $ActionItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActionItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> owner = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> relatedExamId = const Value.absent(),
            Value<int?> relatedMistakeId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              ActionItemsCompanion(
            id: id,
            title: title,
            owner: owner,
            dueDate: dueDate,
            priority: priority,
            status: status,
            relatedExamId: relatedExamId,
            relatedMistakeId: relatedMistakeId,
            createdAt: createdAt,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String> owner = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> relatedExamId = const Value.absent(),
            Value<int?> relatedMistakeId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              ActionItemsCompanion.insert(
            id: id,
            title: title,
            owner: owner,
            dueDate: dueDate,
            priority: priority,
            status: status,
            relatedExamId: relatedExamId,
            relatedMistakeId: relatedMistakeId,
            createdAt: createdAt,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ActionItemsTable, ActionItem>(table),
                    $$ActionItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {relatedExamId = false, relatedMistakeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (relatedExamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relatedExamId,
                    referencedTable:
                        $$ActionItemsTableReferences._relatedExamIdTable(db),
                    referencedColumn:
                        $$ActionItemsTableReferences._relatedExamIdTable(db).id,
                  ) as T;
                }
                if (relatedMistakeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.relatedMistakeId,
                    referencedTable:
                        $$ActionItemsTableReferences._relatedMistakeIdTable(db),
                    referencedColumn: $$ActionItemsTableReferences
                        ._relatedMistakeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ActionItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActionItemsTable,
    ActionItem,
    $$ActionItemsTableFilterComposer,
    $$ActionItemsTableOrderingComposer,
    $$ActionItemsTableAnnotationComposer,
    $$ActionItemsTableCreateCompanionBuilder,
    $$ActionItemsTableUpdateCompanionBuilder,
    (ActionItem, $$ActionItemsTableReferences),
    ActionItem,
    PrefetchHooks Function({bool relatedExamId, bool relatedMistakeId})>;
typedef $$KnowledgeCardsTableCreateCompanionBuilder = KnowledgeCardsCompanion
    Function({
  Value<int> id,
  required String title,
  Value<String> content,
  Value<String> cardType,
  Value<String> tags,
  Value<bool> favorite,
  Value<DateTime> createdAt,
});
typedef $$KnowledgeCardsTableUpdateCompanionBuilder = KnowledgeCardsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<String> cardType,
  Value<String> tags,
  Value<bool> favorite,
  Value<DateTime> createdAt,
});

class $$KnowledgeCardsTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeCardsTable> {
  $$KnowledgeCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get favorite => $composableBuilder(
      column: $table.favorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$KnowledgeCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeCardsTable> {
  $$KnowledgeCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get favorite => $composableBuilder(
      column: $table.favorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$KnowledgeCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeCardsTable> {
  $$KnowledgeCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get cardType =>
      $composableBuilder(column: $table.cardType, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KnowledgeCardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeCardsTable,
    KnowledgeCard,
    $$KnowledgeCardsTableFilterComposer,
    $$KnowledgeCardsTableOrderingComposer,
    $$KnowledgeCardsTableAnnotationComposer,
    $$KnowledgeCardsTableCreateCompanionBuilder,
    $$KnowledgeCardsTableUpdateCompanionBuilder,
    (
      KnowledgeCard,
      BaseReferences<_$AppDatabase, $KnowledgeCardsTable, KnowledgeCard>
    ),
    KnowledgeCard,
    PrefetchHooks Function()> {
  $$KnowledgeCardsTableTableManager(
      _$AppDatabase db, $KnowledgeCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> cardType = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<bool> favorite = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              KnowledgeCardsCompanion(
            id: id,
            title: title,
            content: content,
            cardType: cardType,
            tags: tags,
            favorite: favorite,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String> content = const Value.absent(),
            Value<String> cardType = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<bool> favorite = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              KnowledgeCardsCompanion.insert(
            id: id,
            title: title,
            content: content,
            cardType: cardType,
            tags: tags,
            favorite: favorite,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$KnowledgeCardsTable, KnowledgeCard>(table),
                    BaseReferences<_$AppDatabase, $KnowledgeCardsTable,
                        KnowledgeCard>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KnowledgeCardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeCardsTable,
    KnowledgeCard,
    $$KnowledgeCardsTableFilterComposer,
    $$KnowledgeCardsTableOrderingComposer,
    $$KnowledgeCardsTableAnnotationComposer,
    $$KnowledgeCardsTableCreateCompanionBuilder,
    $$KnowledgeCardsTableUpdateCompanionBuilder,
    (
      KnowledgeCard,
      BaseReferences<_$AppDatabase, $KnowledgeCardsTable, KnowledgeCard>
    ),
    KnowledgeCard,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExamRecordsTableTableManager get examRecords =>
      $$ExamRecordsTableTableManager(_db, _db.examRecords);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$EssayRecordsTableTableManager get essayRecords =>
      $$EssayRecordsTableTableManager(_db, _db.essayRecords);
  $$MistakesTableTableManager get mistakes =>
      $$MistakesTableTableManager(_db, _db.mistakes);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$ActionItemsTableTableManager get actionItems =>
      $$ActionItemsTableTableManager(_db, _db.actionItems);
  $$KnowledgeCardsTableTableManager get knowledgeCards =>
      $$KnowledgeCardsTableTableManager(_db, _db.knowledgeCards);
}
