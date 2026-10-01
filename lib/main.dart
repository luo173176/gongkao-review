import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/providers.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const GkApp(),
  ));
}

class GkApp extends ConsumerWidget {
  const GkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider).themeMode;
    return MaterialApp.router(
      title: '考公复盘',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3457D5)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3457D5),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
