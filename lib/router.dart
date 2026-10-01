import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/cards_page.dart';
import 'pages/card_edit_page.dart';
import 'pages/exam_detail_page.dart';
import 'pages/exam_edit_page.dart';
import 'pages/exams_page.dart';
import 'pages/home_page.dart';
import 'pages/mistake_edit_page.dart';
import 'pages/mistakes_page.dart';
import 'pages/stats_page.dart';
import 'pages/action_edit_page.dart';
import 'pages/actions_page.dart';
import 'pages/profile_page.dart';
import 'pages/review_edit_page.dart';
import 'pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _ScaffoldWithNav(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (c, s) => const HomePage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/exams', builder: (c, s) => const ExamsPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/mistakes', builder: (c, s) => const MistakesPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/stats', builder: (c, s) => const StatsPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/profile', builder: (c, s) => const ProfilePage()),
        ]),
      ],
    ),
    GoRoute(
      path: '/exams/new',
      builder: (c, s) => const ExamEditPage(),
    ),
    GoRoute(
      path: '/exams/:id',
      builder: (c, s) =>
          ExamDetailPage(examId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/exams/:id/edit',
      builder: (c, s) =>
          ExamEditPage(examId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/exams/:id/review',
      builder: (c, s) =>
          ReviewEditPage(examId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/mistakes/new',
      builder: (c, s) => MistakeEditPage(
        initialExamId: int.tryParse(s.uri.queryParameters['examId'] ?? ''),
      ),
    ),
    GoRoute(
      path: '/mistakes/:id/edit',
      builder: (c, s) =>
          MistakeEditPage(mistakeId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/actions',
      builder: (c, s) => const ActionsPage(),
    ),
    GoRoute(
      path: '/actions/new',
      builder: (c, s) => ActionEditPage(
        initialExamId: int.tryParse(s.uri.queryParameters['examId'] ?? ''),
      ),
    ),
    GoRoute(
      path: '/actions/:id/edit',
      builder: (c, s) =>
          ActionEditPage(actionId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/cards',
      builder: (c, s) => const CardsPage(),
    ),
    GoRoute(
      path: '/cards/new',
      builder: (c, s) => const CardEditPage(),
    ),
    GoRoute(
      path: '/cards/:id/edit',
      builder: (c, s) =>
          CardEditPage(cardId: int.parse(s.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/settings',
      builder: (c, s) => const SettingsPage(),
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: '套卷'),
          NavigationDestination(icon: Icon(Icons.rule_outlined), selectedIcon: Icon(Icons.rule), label: '错题'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: '统计'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
