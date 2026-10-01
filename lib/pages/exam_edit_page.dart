import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

class ExamEditPage extends ConsumerStatefulWidget {
  const ExamEditPage({super.key, this.examId});

  final int? examId;

  @override
  ConsumerState<ExamEditPage> createState() => _ExamEditPageState();
}

class _SectionCtrl {
  final total = TextEditingController();
  final correct = TextEditingController();
  final minutes = TextEditingController();
  final target = TextEditingController();
  final note = TextEditingController();

  void dispose() {
    total.dispose();
    correct.dispose();
    minutes.dispose();
    target.dispose();
    note.dispose();
  }
}

class _EssayCtrl {
  final type = TextEditingController();
  final score = TextEditingController();
  final minutes = TextEditingController();
  final problem = TextEditingController();
  final improvement = TextEditingController();

  void dispose() {
    type.dispose();
    score.dispose();
    minutes.dispose();
    problem.dispose();
    improvement.dispose();
  }
}

class _ExamEditPageState extends ConsumerState<ExamEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _duration = TextEditingController();
  final _score = TextEditingController();
  final _note = TextEditingController();
  late final List<_SectionCtrl> _secs =
      List.generate(xingceModules.length, (_) => _SectionCtrl());
  final List<_EssayCtrl> _essays = [];

  String _type = examTypes.first;
  DateTime _date = DateTime.now();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.examId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _duration.dispose();
    _score.dispose();
    _note.dispose();
    for (final s in _secs) {
      s.dispose();
    }
    for (final e in _essays) {
      e.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(dbProvider);
    final exam = await (db.select(db.examRecords)
          ..where((e) => e.id.equals(widget.examId!)))
        .getSingleOrNull();
    if (exam == null || !mounted) return;
    final secs = await (db.select(db.sections)
          ..where((s) => s.examId.equals(exam.id)))
        .get();
    final essays = await (db.select(db.essayRecords)
          ..where((s) => s.examId.equals(exam.id)))
        .get();

    _name.text = exam.name;
    _type = exam.type;
    _date = exam.date;
    _duration.text = exam.durationMinutes > 0
        ? exam.durationMinutes.toString()
        : '';
    _score.text = exam.totalScore?.toString() ?? '';
    _note.text = exam.note;
    for (final s in secs) {
      final i = xingceModules.indexOf(s.module);
      if (i < 0) continue;
      _secs[i].total.text = s.totalQuestions.toString();
      _secs[i].correct.text = s.correctQuestions.toString();
      _secs[i].minutes.text =
          s.timeSpentMinutes > 0 ? s.timeSpentMinutes.toString() : '';
      _secs[i].target.text =
          s.targetRate == null ? '' : (s.targetRate! * 100).toStringAsFixed(0);
      _secs[i].note.text = s.note;
    }
    if (mounted) {
      setState(() {
        _essays.addAll([
          for (final e in essays)
            () {
              final c = _EssayCtrl();
              c.type.text = e.questionType;
              c.score.text = e.score?.toString() ?? '';
              c.minutes.text =
                  e.timeSpentMinutes > 0 ? e.timeSpentMinutes.toString() : '';
              c.problem.text = e.problem;
              c.improvement.text = e.improvement;
              return c;
            }(),
        ]);
        _loaded = true;
      });
    }
  }

  double? _parsePct(String text) {
    final v = double.tryParse(text.trim());
    if (v == null) return null;
    return (v.clamp(0, 100)) / 100;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final name = _name.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final nav = GoRouter.of(context);
    try {
      await db.transaction(() async {
        int examId;
        final companion = ExamRecordsCompanion(
          name: Value(name),
          type: Value(_type),
          date: Value(_date),
          durationMinutes: Value(int.tryParse(_duration.text.trim()) ?? 0),
          totalScore: Value(double.tryParse(_score.text.trim())),
          note: Value(_note.text.trim()),
        );
        if (widget.examId == null) {
          examId = await db.into(db.examRecords).insert(companion);
        } else {
          examId = widget.examId!;
          await (db.update(db.examRecords)
                  ..where((e) => e.id.equals(examId)))
              .write(companion);
        }
        await (db.delete(db.sections)..where((s) => s.examId.equals(examId)))
            .go();
        await (db.delete(db.essayRecords)
              ..where((s) => s.examId.equals(examId)))
            .go();
        for (var i = 0; i < xingceModules.length; i++) {
          final total = int.tryParse(_secs[i].total.text.trim()) ?? 0;
          if (total <= 0) continue;
          await db.into(db.sections).insert(SectionsCompanion.insert(
            examId: examId,
            module: xingceModules[i],
            totalQuestions: Value(total),
            correctQuestions:
                Value(int.tryParse(_secs[i].correct.text.trim()) ?? 0),
            timeSpentMinutes:
                Value(int.tryParse(_secs[i].minutes.text.trim()) ?? 0),
            targetRate: Value(_parsePct(_secs[i].target.text.trim())),
            note: Value(_secs[i].note.text.trim()),
          ));
        }
        for (final e in _essays) {
          final t = e.type.text.trim();
          if (t.isEmpty) continue;
          await db.into(db.essayRecords).insert(EssayRecordsCompanion.insert(
            examId: examId,
            questionType: t,
            score: Value(double.tryParse(e.score.text.trim())),
            timeSpentMinutes: Value(int.tryParse(e.minutes.text.trim()) ?? 0),
            problem: Value(e.problem.text.trim()),
            improvement: Value(e.improvement.text.trim()),
          ));
        }
      });
      nav.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.examId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? '编辑套卷' : '新增套卷'),
        actions: [
          if (editing && !_loaded)
            const Center(
                child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))),
          TextButton(onPressed: _save, child: const Text('保存')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        labelText: '试卷名称', hintText: '如：2026 国考行测模考（一）'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '请填写试卷名称' : null,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: '考试类型'),
                    items: [
                      for (final t in examTypes)
                        DropdownMenuItem(value: t, child: Text(t))
                    ],
                    onChanged: (v) => setState(() => _type = v ?? _type),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('考试日期'),
                    trailing: Text(fmtDate(_date)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                  ),
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _duration,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: '总用时（分钟）'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _score,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: '总分（选填）'),
                      ),
                    ),
                  ]),
                  TextFormField(
                    controller: _note,
                    decoration:
                        const InputDecoration(labelText: '备注', hintText: '整体感受、特殊情况…'),
                    maxLines: 2,
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('行测模块',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('填了总题数的模块才会保存；正确数、用时、目标正确率选填。',
                        style: Theme.of(context).textTheme.bodySmall),
                    for (var i = 0; i < xingceModules.length; i++)
                      _sectionFields(i),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('申论', style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () =>
                            setState(() => _essays.add(_EssayCtrl())),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('添加题目'),
                      ),
                    ]),
                    if (_essays.isEmpty)
                      Text('没有申论题可跳过。可按题型逐题记录得分与问题。',
                          style: Theme.of(context).textTheme.bodySmall),
                    for (var i = 0; i < _essays.length; i++)
                      _essayFields(i),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48)),
              child: const Text('保存套卷'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionFields(int i) {
    final c = _secs[i];
    final total = int.tryParse(c.total.text) ?? 0;
    final correct = int.tryParse(c.correct.text) ?? 0;
    final summary = total > 0
        ? ' ${fmtRate(total > 0 ? correct / total : null)}'
        : '';
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(xingceModules[i]),
      subtitle: total > 0 ? Text('$correct/$total$summary') : const Text('未录入'),
      children: [
        Row(children: [
          Expanded(
              child: _num(c.total, '总题数',
                  validator: (v) => v == null || v <= 0 ? '填总题数' : null)),
          const SizedBox(width: 8),
          Expanded(child: _num(c.correct, '正确数')),
        ]),
        Row(children: [
          Expanded(child: _num(c.minutes, '用时（分）')),
          const SizedBox(width: 8),
          Expanded(child: _num(c.target, '目标正确率%')),
        ]),
        TextFormField(
          controller: c.note,
          decoration: const InputDecoration(labelText: '备注'),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _essayFields(int i) {
    final c = _essays[i];
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(c.type.text.trim().isEmpty ? '申论题 ${i + 1}' : c.type.text),
      children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              controller: c.type,
              decoration: const InputDecoration(labelText: '题型', hintText: '如：归纳概括'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _num(c.score, '得分')),
          const SizedBox(width: 8),
          Expanded(child: _num(c.minutes, '用时（分）')),
        ]),
        TextFormField(
          controller: c.problem,
          decoration: const InputDecoration(labelText: '问题'),
          maxLines: 2,
        ),
        TextFormField(
          controller: c.improvement,
          decoration: const InputDecoration(labelText: '改进点'),
          maxLines: 2,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              c.dispose();
              setState(() => _essays.removeAt(i));
            },
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('删除此题'),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _num(TextEditingController controller, String label,
      {String? Function(int?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: validator == null
          ? null
          : (v) {
              final n = int.tryParse(v?.trim() ?? '');
              return validator(n);
            },
      onChanged: (_) => setState(() {}),
    );
  }
}
