import 'package:elanel_asistencia_it/config/router/app_router.dart';
import 'package:elanel_asistencia_it/config/theme/app_theme.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final appTheme = AppTheme();

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      darkTheme: appTheme.getDarkTheme(),
      themeMode: themeMode,
    );
  }
}
