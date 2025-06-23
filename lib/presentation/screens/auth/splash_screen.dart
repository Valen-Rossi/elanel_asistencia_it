import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:elanel_asistencia_it/presentation/providers/auth/auth_provider.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/users_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _usersLoaded = false;

  @override
  void initState() {
    super.initState();
    // Cargar usuarios al iniciar
    Future.microtask(() async {
      await ref.read(usersProvider.notifier).loadUsers();
      setState(() => _usersLoaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    if (!_usersLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return authState.when(
      data: (user) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;

          if (user != null) {
            context.go('/');
          } else {
            context.go('/login');
          }
        });

        return const SizedBox.shrink(); // necesario para evitar build
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Scaffold(
        body: Center(child: Text('Error al cargar la app')),
      ),
    );
  }
}
