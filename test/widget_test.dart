import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gongkao_review/widgets/common.dart';
import 'package:gongkao_review/widgets/countdown_card.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('CountdownCard 显示倒计时天数', (tester) async {
    final target = DateTime.now().add(const Duration(days: 30));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: CountdownCard(examDate: target)),
    ));
    expect(find.text('30 天'), findsOneWidget);
    expect(find.text('距离考试还有'), findsOneWidget);
    expect(find.text(DateFormat('yyyy-MM-dd').format(target)), findsOneWidget);
  });

  testWidgets('CountdownCard 未设置日期时提示', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: CountdownCard(examDate: null)),
    ));
    expect(find.text('未设置考试日期'), findsOneWidget);
    expect(find.text('点击设置，开始倒计时'), findsOneWidget);
  });

  testWidgets('ModuleRateRow 显示题数、用时与目标正确率', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ModuleRateRow(
          module: '言语理解',
          correct: 24,
          total: 40,
          minutes: 35,
          targetRate: 0.8,
        ),
      ),
    ));
    expect(find.text('言语理解'), findsOneWidget);
    expect(find.text('24/40 · 35分钟'), findsOneWidget);
    expect(find.text('目标 80%'), findsOneWidget);
  });
}
