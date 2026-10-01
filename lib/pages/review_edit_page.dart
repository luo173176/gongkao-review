import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import '../widgets/common.dart';

class ReviewEditPage extends ConsumerStatefulWidget {
  const ReviewEditPage({super.key, required this.examId});

  final int examId;

  @override
  ConsumerState<ReviewEditPage> createState() => _ReviewEditPageState();
}

class _ReviewEditPageState extends ConsumerState<ReviewEditPage> {
  final _keep = TextEditingController();
  final _problem = TextEditingController();
  final _attempt = TextEditingController();
  final _action = TextEditingController();
  bool _kpt = true;
  bool _loaded = false;
  int? _reviewId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _keep.dispose();
    _problem.dispose();
    _attempt.dispose();
    _action.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(dbProvider);
    final existing = await (db.select(db.reviews)
          ..where((r) => r.examId.equals(widget.examId))
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
        .get();
    if (!mounted) return;
    if (existing.isNotEmpty) {
      final r = existing.first;
      setState(() {
        _reviewId = r.id;
        _keep.text = r.keep;
        _problem.text = r.problem;
        _attempt.text = r.attempt;
        _action.text = r.action;
        _loaded = true;
      });
    } else {
      setState(() => _loaded = true);
    }
  }

  List<String> get _labels => _kpt
      ? ['保持（K）', '问题（P）', '尝试（T）', '行动（A）']
      : ['计划（P）', '执行（D）', '检查（C）', '处理（A）'];

  List<String> get _hints => _kpt
      ? [
          '哪些做对了、值得保持？',
          '哪里丢分了？根本原因是什么？',
          '打算尝试什么新方法？',
          '接下来具体做什么？（每行一条，可一键生成行动项）',
        ]
      : [
          '上次计划的完成情况？',
          '实际执行中出现了什么偏差？',
          '效果如何？原因是什么？',
          '如何改进？（每行一条，可一键生成行动项）',
        ];

  Future<void> _save() async {
    final db = ref.read(dbProvider);
    final messenger = ScaffoldMessenger.of(context);
    final nav = GoRouter.of(context);
    try {
      final companion = ReviewsCompanion(
        examId: Value(widget.examId),
        keep: Value(_keep.text.trim()),
        problem: Value(_problem.text.trim()),
        attempt: Value(_attempt.text.trim()),
        action: Value(_action.text.trim()),
      );
      if (_reviewId == null) {
        await db.into(db.reviews).insert(companion);
      } else {
        await (db.update(db.reviews)..where((r) => r.id.equals(_reviewId!)))
            .write(companion);
      }
      nav.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<void> _generateActions() async {
    final lines = _action.text
        .split('\n')
        .map((l) => l.trim().replaceAll(RegExp(r'^[-*•\d.、\s]+'), ''))
        .where((l) => l.isNotEmpty)
        .toSet()
        .toList();
    if (lines.isEmpty) {
      showSnack(context, '「行动」一栏还是空的，先写几条吧');
      return;
    }
    final db = ref.read(dbProvider);
    for (final line in lines) {
      await db.into(db.actionItems).insert(ActionItemsCompanion.insert(
        title: line,
        priority: const Value('中'),
        relatedExamId: Value(widget.examId),
      ));
    }
    if (!mounted) return;
    showSnack(context, '已生成 ${lines.length} 个行动项，可在「我的-行动项」查看');
  }

  @override
  Widget build(BuildContext context) {
    final sections =
        ref.watch(sectionsProvider(widget.examId)).valueOrNull ??
            const <Section>[];
    final mistakes = ref.watch(mistakesOfExamProvider(widget.examId)).valueOrNull ??
        const <Mistake>[];
    final actions =
        ref.watch(actionItemsProvider).valueOrNull ?? const <ActionItem>[];

    final acc = overallAccuracy(sections);
    final openActions = actions.where((a) => a.status != '完成').toList();
    final reasons = reasonDistribution(mistakes);

    return Scaffold(
      appBar: AppBar(
        title: Text(_reviewId == null ? '生成复盘报告' : '编辑复盘报告'),
        actions: [
          if (!_loaded)
            const Center(
                child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2))),
          TextButton(onPressed: _save, child: const Text('保存')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('本次套卷数据汇总',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      '行测 ${fmtRate(acc)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ]),
                  if (sections.isEmpty)
                    Text('该套卷还没录入模块数据。',
                        style: Theme.of(context).textTheme.bodySmall)
                  else
                    for (final s in sections)
                      ModuleRateRow(
                        module: s.module,
                        correct: s.correctQuestions,
                        total: s.totalQuestions,
                        minutes: s.timeSpentMinutes,
                        targetRate: s.targetRate,
                      ),
                  if (reasons.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        for (final e in reasons.entries)
                          Chip(
                            label: Text('${e.key} ×${e.value}'),
                            visualDensity: VisualDensity.compact,
                            labelStyle: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ],
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
                  Text('上次未完成的行动项',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  if (openActions.isEmpty)
                    Text('没有未完成的行动项 🎉',
                        style: Theme.of(context).textTheme.bodySmall)
                  else
                    for (final a in openActions.take(5))
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.check_circle_outline,
                            size: 18),
                        title: Text(a.title,
                            style: const TextStyle(fontSize: 13)),
                        subtitle: a.dueDate == null
                            ? null
                            : Text(
                                '截止 ${fmtDate(a.dueDate!)} · ${a.priority}优先级',
                                style: const TextStyle(fontSize: 11)),
                      ),
                  if (openActions.length > 5)
                    Text('…等 ${openActions.length} 项未完成',
                        style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('KPT 模板')),
              ButtonSegment(value: false, label: Text('PDCA 模板')),
            ],
            selected: {_kpt},
            onSelectionChanged: (s) => setState(() => _kpt = s.first),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < 4; i++) ...[
            TextFormField(
              controller: [
                _keep,
                _problem,
                _attempt,
                _action,
              ][i],
              decoration: InputDecoration(
                labelText: _labels[i],
                hintText: _hints[i],
                alignLabelWithHint: true,
              ),
              minLines: i == 3 ? 3 : 2,
              maxLines: i == 3 ? 6 : 4,
            ),
            const SizedBox(height: 12),
          ],
          OutlinedButton.icon(
            onPressed: _generateActions,
            icon: const Icon(Icons.playlist_add),
            label: const Text('从「行动」一键生成行动项'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _save,
            style:
                FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            child: const Text('保存复盘报告'),
          ),
        ],
      ),
    );
  }
}
