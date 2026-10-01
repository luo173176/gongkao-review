import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 通用小组件与格式化工具。

String fmtDate(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

String fmtDateTime(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);

String fmtRate(double? rate) =>
    rate == null ? '--' : '${(rate * 100).toStringAsFixed(1)}%';

Future<bool> confirmDialog(
  BuildContext context, {
  String title = '确认操作',
  required String content,
  String confirmText = '删除',
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmText),
        ),
      ],
    ),
  );
  return ok ?? false;
}

void showSnack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.onTap,
  });

  final String title;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: scheme.primary, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyHint extends StatelessWidget {
  const EmptyHint(this.text, {super.key, this.icon = Icons.inbox_outlined});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: scheme.onSurfaceVariant.withAlpha(120)),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

/// 模块正确率行：名称 + 进度条 + 目标对比。
class ModuleRateRow extends StatelessWidget {
  const ModuleRateRow({
    super.key,
    required this.module,
    required this.correct,
    required this.total,
    this.minutes = 0,
    this.targetRate,
  });

  final String module;
  final int correct;
  final int total;
  final int minutes;
  final double? targetRate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final actual = total > 0 ? correct / total : null;
    final belowTarget = actual != null && targetRate != null && actual < targetRate!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(module, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(
                total > 0 ? '$correct/$total · $minutes分钟' : '未录入',
                style: TextStyle(
                    fontSize: 12, color: scheme.onSurfaceVariant),
              ),
              if (targetRate != null) ...[
                const SizedBox(width: 8),
                Text(
                  '目标 ${(targetRate! * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: belowTarget ? scheme.error : scheme.primary,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: actual,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            color: belowTarget ? scheme.error : scheme.primary,
            backgroundColor: scheme.surfaceContainerHighest.withAlpha(120),
          ),
        ],
      ),
    );
  }
}
