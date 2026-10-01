import 'package:flutter/material.dart';

import '../services/stats.dart';
import 'common.dart';

/// 仪表盘顶部的考试倒计时卡片。examDate 为空时提示去设置。
class CountdownCard extends StatelessWidget {
  const CountdownCard({super.key, required this.examDate, this.onTap});

  final DateTime? examDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final days = examDate == null
        ? null
        : dateOnly(examDate!).difference(dateOnly(DateTime.now())).inDays;

    final String headline;
    final String sub;
    if (days == null) {
      headline = '未设置考试日期';
      sub = '点击设置，开始倒计时';
    } else if (days > 0) {
      headline = '$days 天';
      sub = '距离考试还有';
    } else if (days == 0) {
      headline = '就是今天';
      sub = '考试加油！';
    } else {
      headline = '${-days} 天';
      sub = '考试已结束';
    }

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.event_available, color: scheme.primary, size: 36),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sub,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          )),
                  Text(
                    headline,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              if (examDate != null)
                Text(fmtDate(examDate!),
                    style: TextStyle(color: scheme.onSurfaceVariant)),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
