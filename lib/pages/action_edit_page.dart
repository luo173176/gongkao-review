import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

class ActionEditPage extends ConsumerStatefulWidget {
  const ActionEditPage({super.key, this.actionId, this.initialExamId});

  final int? actionId;
  final int? initialExamId;

  @override
  ConsumerState<ActionEditPage> createState() => _ActionEditPageState();
}

class _ActionEditPageState extends ConsumerState<ActionEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _owner = TextEditingController();

  DateTime? _dueDate;
  String _priority = priorities[1];
  String _status = actionStatuses.first;
  int _examSel = -1;
  int _mistakeSel = -1;
  DateTime? _completedAt;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _examSel = widget.initialExamId ?? -1;
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _title.dispose();
    _owner.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final owner = ref.read(settingsProvider).owner;
    if (mounted && _owner.text.isEmpty) {
      setState(() => _owner.text = owner);
    }
    if (widget.actionId == null) return;
    final db = ref.read(dbProvider);
    final a = await (db.select(db.actionItems)
          ..where((x) => x.id.equals(widget.actionId!)))
        .getSingleOrNull();
    if (a == null || !mounted) return;
    setState(() {
      _title.text = a.title;
      _owner.text = a.owner;
      _dueDate = a.dueDate;
      _priority = a.priority;
      _status = a.status;
      _examSel = a.relatedExamId ?? -1;
      _mistakeSel = a.relatedMistakeId ?? -1;
      _completedAt = a.completedAt;
      _loaded = true;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final messenger = ScaffoldMessenger.of(context);
    final nav = GoRouter.of(context);
    try {
      final companion = ActionItemsCompanion(
        title: Value(_title.text.trim()),
        owner: Value(_owner.text.trim().isEmpty ? '我' : _owner.text.trim()),
        dueDate: Value(_dueDate),
        priority: Value(_priority),
        status: Value(_status),
        relatedExamId: Value(_examSel > 0 ? _examSel : null),
        relatedMistakeId: Value(_mistakeSel > 0 ? _mistakeSel : null),
        completedAt:
            Value(_status == '完成' ? (_completedAt ?? DateTime.now()) : null),
      );
      if (widget.actionId == null) {
        await db.into(db.actionItems).insert(companion);
      } else {
        await (db.update(db.actionItems)
                ..where((x) => x.id.equals(widget.actionId!)))
            .write(companion);
      }
      nav.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<void> _delete() async {
    final ok = await confirmDialog(context, content: '确定删除这个行动项吗？');
    if (!ok) return;
    final db = ref.read(dbProvider);
    await (db.delete(db.actionItems)
          ..where((x) => x.id.equals(widget.actionId!)))
        .go();
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final mistakes =
        ref.watch(mistakesProvider).valueOrNull ?? const <Mistake>[];
    final editing = widget.actionId != null;

    String mistakeLabel(Mistake m) {
      final base = m.knowledgePoint.isEmpty
          ? (m.question.isEmpty ? '错题 #${m.id}' : m.question)
          : m.knowledgePoint;
      return base.length > 20 ? '${base.substring(0, 20)}…' : base;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? '编辑行动项' : '新增行动项'),
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
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                  labelText: '标题', hintText: '要做的具体动作'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '请填写标题' : null,
            ),
            TextFormField(
              controller: _owner,
              decoration: const InputDecoration(
                  labelText: '负责人', hintText: '默认「我」'),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('截止日期'),
              subtitle: _dueDate == null
                  ? const Text('未设置')
                  : Text(fmtDate(_dueDate!)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                if (_dueDate != null)
                  IconButton(
                    tooltip: '清除',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _dueDate = null),
                  ),
                IconButton(
                  tooltip: '选择日期',
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => _dueDate = picked);
                  },
                ),
              ]),
            ),
            Row(children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _priority,
                  decoration: const InputDecoration(labelText: '优先级'),
                  items: [
                    for (final p in priorities)
                      DropdownMenuItem(value: p, child: Text(p))
                  ],
                  onChanged: (v) => setState(() => _priority = v ?? _priority),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: '状态'),
                  items: [
                    for (final s in actionStatuses)
                      DropdownMenuItem(value: s, child: Text(s))
                  ],
                  onChanged: (v) => setState(() => _status = v ?? _status),
                ),
              ),
            ]),
            DropdownButtonFormField<int>(
              initialValue: _examSel,
              decoration: const InputDecoration(labelText: '关联套卷（选填）'),
              items: [
                const DropdownMenuItem(value: -1, child: Text('不关联')),
                for (final e in exams)
                  DropdownMenuItem(value: e.id, child: Text(e.name)),
              ],
              onChanged: (v) => setState(() => _examSel = v ?? -1),
            ),
            DropdownButtonFormField<int>(
              initialValue: _mistakeSel,
              decoration: const InputDecoration(labelText: '关联错题（选填）'),
              items: [
                const DropdownMenuItem(value: -1, child: Text('不关联')),
                for (final m in mistakes.take(50))
                  DropdownMenuItem(value: m.id, child: Text(mistakeLabel(m))),
              ],
              onChanged: (v) => setState(() => _mistakeSel = v ?? -1),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _save,
              style:
                  FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('保存行动项'),
            ),
            if (editing) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('删除行动项'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
