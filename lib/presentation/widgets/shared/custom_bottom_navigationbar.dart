import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/current_user_provider.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context, User? user) {
    final location = GoRouterState.of(context).matchedLocation;
    final isAdmin = user?.role == UserRole.admin;
    final isTechnician = user?.role == UserRole.technician;

    if (location == '/') return 0;
    if (location == '/tickets') return 1;

    if (isAdmin) {
      if (location == '/users') return 2;
      if (location == '/inventary') return 3;
      if (location == '/help') return 4;
    }

    if (isTechnician) {
      if (location == '/inventary') return 2;
      if (location == '/help') return 3;
    }

    // Cliente
    if (location == '/help') return 2;

    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentAppUserProvider);

    // Mientras no se haya cargado el usuario, devolvemos una barra vacía
    if (currentUser == null) return const SizedBox.shrink();

    final isAdmin = currentUser.role == UserRole.admin;
    final isTechnician = currentUser.role == UserRole.technician;
    // final isClient = currentUser.role == UserRole.client;

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), label: 'Tickets'),
      if (isAdmin)
        const BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), label: 'Usuarios'),
      if (isAdmin || isTechnician)
        const BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
      const BottomNavigationBarItem(icon: Icon(Icons.help_outline_rounded), label: 'Ayuda'),
    ];

    final routes = <String>[
      '/',
      '/tickets',
      if (isAdmin) '/users',
      if (isAdmin || isTechnician) '/inventary',
      '/help',
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(context, currentUser),
      items: items,
      onTap: (index) {
        context.go(routes[index]);
      },
    );
  }
}
