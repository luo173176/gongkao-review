import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

class CardEditPage extends ConsumerStatefulWidget {
  const CardEditPage({super.key, this.cardId});

  final int? cardId;

  @override
  ConsumerState<CardEditPage> createState() => _CardEditPageState();
}

class _CardEditPageState extends ConsumerState<CardEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  final _tags = TextEditingController();

  String _type = cardTypes.last;
  bool _favorite = false;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.cardId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final db = ref.read(dbProvider);
    final c = await (db.select(db.knowledgeCards)
          ..where((x) => x.id.equals(widget.cardId!)))
        .getSingleOrNull();
    if (c == null || !mounted) return;
    setState(() {
      _title.text = c.title;
      _content.text = c.content;
      _tags.text = c.tags;
      _type = c.cardType;
      _favorite = c.favorite;
      _loaded = true;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = ref.read(dbProvider);
    final messenger = ScaffoldMessenger.of(context);
    final nav = GoRouter.of(context);
    try {
      final companion = KnowledgeCardsCompanion(
        title: Value(_title.text.trim()),
        content: Value(_content.text.trim()),
        cardType: Value(_type),
        tags: Value(_tags.text.trim()),
        favorite: Value(_favorite),
      );
      if (widget.cardId == null) {
        await db.into(db.knowledgeCards).insert(companion);
      } else {
        await (db.update(db.knowledgeCards)
                ..where((x) => x.id.equals(widget.cardId!)))
            .write(companion);
      }
      nav.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<void> _delete() async {
    final ok = await confirmDialog(context, content: '确定删除这张卡片吗？');
    if (!ok) return;
    final db = ref.read(dbProvider);
    await (db.delete(db.knowledgeCards)
          ..where((x) => x.id.equals(widget.cardId!)))
        .go();
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.cardId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? '编辑卡片' : '记卡片'),
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
                  labelText: '标题', hintText: '如：增长率比较的速算技巧'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '请填写标题' : null,
            ),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: '类型'),
              items: [
                for (final t in cardTypes) DropdownMenuItem(value: t, child: Text(t))
              ],
              onChanged: (v) => setState(() => _type = v ?? _type),
            ),
            TextFormField(
              controller: _content,
              decoration: const InputDecoration(
                  labelText: '内容', hintText: '公式、素材、答题思路、经验教训…'),
              minLines: 6,
              maxLines: 14,
            ),
            TextFormField(
              controller: _tags,
              decoration: const InputDecoration(
                  labelText: '标签（逗号分隔）', hintText: '如：资料分析,速算'),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('收藏'),
              value: _favorite,
              onChanged: (v) => setState(() => _favorite = v),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _save,
              style:
                  FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('保存卡片'),
            ),
            if (editing) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('删除卡片'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
