import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

class MistakeEditPage extends ConsumerStatefulWidget {
  const MistakeEditPage({super.key, this.mistakeId, this.initialExamId});

  final int? mistakeId;
  final int? initialExamId;

  @override
  ConsumerState<MistakeEditPage> createState() => _MistakeEditPageState();
}

class _MistakeEditPageState extends ConsumerState<MistakeEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _knowledgePoint = TextEditingController();
  final _question = TextEditingController();
  final _myAnswer = TextEditingController();
  final _correctAnswer = TextEditingController();
  final _correctIdea = TextEditingController();
  final _action = TextEditingController();
  final _tags = TextEditingController();

  String _module = '';
  String _reason = wrongReasons.first;
  int _examSel = -1;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _examSel = widget.initialExamId ?? -1;
    if (widget.mistakeId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    }
  }

  @override
  void dispose() {
    _knowledgePoint.dispose();
    _question.dispose();
    _myAnswer.dispose();
    _correctAnswer.dispose();
    _correctIdea.dispose();
    _action.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(dbProvider);
    final m = await (db.select(db.mistakes)
          ..where((x) => x.id.equals(widget.mistakeId!)))
        .getSingleOrNull();
    if (m == null || !mounted) return;
    setState(() {
      _knowledgePoint.text = m.knowledgePoint;
      _question.text = m.question;
      _myAnswer.text = m.myAnswer;
      _correctAnswer.text = m.correctAnswer;
      _correctIdea.text = m.correctIdea;
      _action.text = m.action;
      _tags.text = m.tags;
      _module = m.module;
      _reason = m.wrongReason;
      _examSel = m.examId ?? -1;
      _loaded = true;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_knowledgePoint.text.trim().isEmpty &&
        _question.text.trim().isEmpty) {
      showSnack(context, '知识点和题目摘要至少填一个');
      return;
    }
    final db = ref.read(dbProvider);
    final messenger = ScaffoldMessenger.of(context);
    final nav = GoRouter.of(context);
    try {
      final companion = MistakesCompanion(
        examId: Value(_examSel > 0 ? _examSel : null),
        module: Value(_module),
        knowledgePoint: Value(_knowledgePoint.text.trim()),
        question: Value(_question.text.trim()),
        myAnswer: Value(_myAnswer.text.trim()),
        correctAnswer: Value(_correctAnswer.text.trim()),
        wrongReason: Value(_reason),
        correctIdea: Value(_correctIdea.text.trim()),
        action: Value(_action.text.trim()),
        tags: Value(_tags.text.trim()),
      );
      if (widget.mistakeId == null) {
        await db.into(db.mistakes).insert(companion);
      } else {
        await (db.update(db.mistakes)
                ..where((x) => x.id.equals(widget.mistakeId!)))
            .write(companion);
      }
      nav.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<void> _delete() async {
    final ok = await confirmDialog(context, content: '确定删除这条错题吗？');
    if (!ok) return;
    final db = ref.read(dbProvider);
    await (db.delete(db.mistakes)..where((x) => x.id.equals(widget.mistakeId!)))
        .go();
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final editing = widget.mistakeId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? '编辑错题' : '记错题'),
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
            DropdownButtonFormField<int>(
              initialValue: _examSel,
              decoration: const InputDecoration(labelText: '所属套卷（选填）'),
              items: [
                const DropdownMenuItem(value: -1, child: Text('不关联')),
                for (final e in exams)
                  DropdownMenuItem(value: e.id, child: Text(e.name)),
              ],
              onChanged: (v) => setState(() => _examSel = v ?? -1),
            ),
            DropdownButtonFormField<String>(
              initialValue: _module,
              decoration: const InputDecoration(labelText: '模块'),
              items: [
                const DropdownMenuItem(value: '', child: Text('未分类')),
                for (final m in xingceModules)
                  DropdownMenuItem(value: m, child: Text(m)),
              ],
              onChanged: (v) => setState(() => _module = v ?? ''),
            ),
            TextFormField(
              controller: _knowledgePoint,
              decoration: const InputDecoration(
                  labelText: '知识点', hintText: '如：资料分析·增长率比较'),
            ),
            TextFormField(
              controller: _question,
              decoration: const InputDecoration(
                  labelText: '题目摘要', hintText: '用自己的话概括题目与选项'),
              maxLines: 3,
            ),
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: _myAnswer,
                  decoration: const InputDecoration(labelText: '我的答案'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _correctAnswer,
                  decoration: const InputDecoration(labelText: '正确答案'),
                ),
              ),
            ]),
            DropdownButtonFormField<String>(
              initialValue: _reason,
              decoration: const InputDecoration(labelText: '错误原因'),
              items: [
                for (final r in wrongReasons)
                  DropdownMenuItem(value: r, child: Text(r))
              ],
              onChanged: (v) => setState(() => _reason = v ?? _reason),
            ),
            TextFormField(
              controller: _correctIdea,
              decoration: const InputDecoration(
                  labelText: '正确思路', hintText: '这道题应该怎么做'),
              maxLines: 3,
            ),
            TextFormField(
              controller: _action,
              decoration: const InputDecoration(
                  labelText: '改进动作', hintText: '如：限时 20 题专项训练'),
              maxLines: 2,
            ),
            TextFormField(
              controller: _tags,
              decoration: const InputDecoration(
                  labelText: '标签（逗号分隔）', hintText: '如：片段阅读,高频考点'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              style:
                  FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('保存错题'),
            ),
            if (editing) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('删除错题'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
