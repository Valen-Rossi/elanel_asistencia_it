import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/current_user_provider.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context, bool isAdmin) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location == '/') return 0;
    if (location == '/tickets') return 1;
    if (isAdmin) {
      if (location == '/users') return 2;
      if (location == '/inventary') return 3;
      if (location == '/help') return 4;
    } else {
      if (location == '/inventary') return 2;
      if (location == '/help') return 3;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentAppUserProvider);
    final isAdmin = currentUser?.role == UserRole.admin;

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), label: 'Tickets'),
      if (isAdmin)
        const BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), label: 'Usuarios'),
      const BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Inventario'),
      const BottomNavigationBarItem(icon: Icon(Icons.help_outline_rounded), label: 'Ayuda'),
    ];

    final routes = <String>[
      '/',
      '/tickets',
      if (isAdmin) '/users',
      '/inventary',
      '/help',
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(context, isAdmin),
      items: items,
      onTap: (index) {
        context.go(routes[index]);
      },
    );
  }
}
