import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/providers.dart';
import '../services/backup.dart';
import '../services/csv.dart';
import '../widgets/common.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _header(context, '备考信息'),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.event_outlined),
                  title: const Text('考试日期'),
                  subtitle: settings.examDate == null
                      ? const Text('未设置')
                      : Text(fmtDate(settings.examDate!)),
                  trailing: settings.examDate == null
                      ? const Icon(Icons.chevron_right)
                      : IconButton(
                          tooltip: '清除',
                          icon: const Icon(Icons.close),
                          onPressed: () =>
                              ref.read(settingsProvider.notifier).setExamDate(null),
                        ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: settings.examDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      await ref
                          .read(settingsProvider.notifier)
                          .setExamDate(picked);
                    }
                  },
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('目标分数'),
                  subtitle: settings.targetScore == null
                      ? const Text('未设置')
                      : Text('${settings.targetScore} 分'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _editNumber(
                    context,
                    title: '目标分数',
                    initial: settings.targetScore,
                    onSave: (v) => ref
                        .read(settingsProvider.notifier)
                        .setTargetScore(v),
                  ),
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('负责人（行动项默认）'),
                  subtitle: Text(settings.owner),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _editOwner(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _header(context, '外观'),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.system, label: Text('跟随系统')),
                  ButtonSegment(value: ThemeMode.light, label: Text('浅色')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('深色')),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (s) => ref
                    .read(settingsProvider.notifier)
                    .setThemeMode(s.first),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _header(context, '数据管理'),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.file_upload_outlined),
                  title: const Text('导出 JSON 备份'),
                  subtitle: const Text('全部数据，可用于恢复'),
                  onTap: () => _exportJson(context, ref),
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  leading: const Icon(Icons.table_chart_outlined),
                  title: const Text('导出错题 CSV'),
                  subtitle: const Text('可用 Excel 打开'),
                  onTap: () => _exportCsv(context, ref),
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  leading: const Icon(Icons.file_download_outlined),
                  title: const Text('导入 JSON 备份'),
                  subtitle: const Text('将清空现有数据并导入'),
                  onTap: () => _importJson(context, ref),
                ),
                const Divider(height: 1, indent: 16),
                ListTile(
                  leading: Icon(Icons.delete_forever,
                      color: Theme.of(context).colorScheme.error),
                  title: Text('清空所有数据',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                  onTap: () => _clearAll(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '考公复盘 v0.1.0\n离线优先，数据存储在本机 SQLite 数据库。'
                '导出的备份文件请妥善保存。',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
    );
  }

  Future<void> _editNumber(
    BuildContext context, {
    required String title,
    required double? initial,
    required Future<void> Function(double?) onSave,
  }) async {
    final controller = TextEditingController(text: initial?.toString() ?? '');
    final v = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(suffixText: '分'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('取消')),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, double.tryParse(controller.text.trim())),
            child: const Text('保存'),
          ),
        ],
      ),
    );
    await onSave(v);
  }

  Future<void> _editOwner(BuildContext context, WidgetRef ref) async {
    final current = ref.read(settingsProvider).owner;
    final controller = TextEditingController(text: current);
    final v = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('负责人'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, controller.text.trim()),
              child: const Text('保存')),
        ],
      ),
    );
    if (v != null && v.isNotEmpty) {
      await ref.read(settingsProvider.notifier).setOwner(v);
    }
  }

  Future<File> _writeTemp(String suffix, String content) async {
    final dir = await getTemporaryDirectory();
    final stamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${dir.path}/gongkao_review_${stamp}_$suffix');
    return file.writeAsString(content);
  }

  Future<void> _exportJson(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final data = await exportAll(ref.read(dbProvider));
      final file = await _writeTemp('backup.json', encodeBackup(data));
      await Share.shareXFiles([XFile(file.path)], text: '考公复盘数据备份');
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('导出失败：$e')));
    }
  }

  Future<void> _exportCsv(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final exams = ref.read(examsProvider).valueOrNull ?? [];
      final mistakes = ref.read(mistakesProvider).valueOrNull ?? [];
      final names = {for (final e in exams) e.id: e.name};
      final csv = mistakesCsv([
        for (final m in mistakes)
          MistakeCsvRow(
            examName: m.examId == null ? '' : (names[m.examId!] ?? ''),
            mistake: m,
          ),
      ]);
      final file = await _writeTemp('mistakes.csv', csv);
      await Share.shareXFiles([XFile(file.path)], text: '错题本 CSV');
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('导出失败：$e')));
    }
  }

  Future<void> _importJson(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.any,
        dialogTitle: '选择备份 JSON 文件',
      );
      final path = res?.files.single.path;
      if (path == null) return;
      final data = decodeBackup(await File(path).readAsString());
      if (!context.mounted) return;
      final ok = await confirmDialog(
        context,
        title: '导入备份',
        content: '导入将清空当前所有数据，并用备份内容替换。确定继续吗？',
        confirmText: '导入',
      );
      if (!ok) return;
      await importAll(ref.read(dbProvider), data);
      messenger.showSnackBar(const SnackBar(content: Text('导入完成')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('导入失败：$e')));
    }
  }

  Future<void> _clearAll(BuildContext context, WidgetRef ref) async {
    final ok1 = await confirmDialog(
      context,
      title: '清空所有数据',
      content: '所有套卷、错题、复盘、行动项、卡片将被删除。此操作不可恢复，建议先导出备份。',
      confirmText: '继续',
    );
    if (!ok1 || !context.mounted) return;
    final ok2 = await confirmDialog(
      context,
      title: '再次确认',
      content: '真的要清空全部数据吗？',
      confirmText: '清空',
    );
    if (!ok2 || !context.mounted) return;
    await clearAll(ref.read(dbProvider));
    if (context.mounted) showSnack(context, '已清空全部数据');
  }
}
