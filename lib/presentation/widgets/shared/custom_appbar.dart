import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeMode = ref.watch(themeModeProvider);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.diamond_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Elanel Asistencia IT', style: textTheme.titleMedium),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final current = ref.read(themeModeProvider);
                  ref.read(themeModeProvider.notifier).state =
                      current == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                },
                icon: Icon(themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
              ),
              IconButton(
                onPressed: () async {
                  await ref.read(authServiceProvider).logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                tooltip: 'Cerrar sesión',
                icon: const Icon(Icons.logout),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
