import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../providers/providers.dart';
import '../services/stats.dart';
import '../widgets/common.dart';

class ExamsPage extends ConsumerWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exams = ref.watch(examsProvider).valueOrNull ?? const <ExamRecord>[];
    final allSections =
        ref.watch(allSectionsProvider).valueOrNull ?? const <Section>[];

    final byExam = <int, List<Section>>{};
    for (final s in allSections) {
      (byExam[s.examId] ??= []).add(s);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('套卷记录')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/exams/new'),
        icon: const Icon(Icons.add),
        label: const Text('新增套卷'),
      ),
      body: exams.isEmpty
          ? const EmptyHint('还没有套卷记录。\n点右下角「新增套卷」，录入第一张卷子吧。')
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: exams.length,
              itemBuilder: (context, i) {
                final e = exams[i];
                final acc = overallAccuracy(byExam[e.id] ?? const []);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(e.name),
                    subtitle: Text(
                        '${e.type} · ${fmtDate(e.date)} · ${e.durationMinutes} 分钟'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          fmtRate(acc),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (e.totalScore != null)
                          Text('总分 ${e.totalScore}',
                              style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                    onTap: () => context.push('/exams/${e.id}'),
                  ),
                );
              },
            ),
    );
  }
}
