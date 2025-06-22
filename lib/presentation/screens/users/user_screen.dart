import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserScreen extends ConsumerWidget {
  static const name = 'user-screen';
  final String userId;

  const UserScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userByIdProvider(userId));
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del Usuario',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _UserView(user: user),
    );
  }
}

class _UserView extends StatelessWidget {
  final User user;

  const _UserView({required this.user});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    // final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _UserInfoCard(user: user),
        ],
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final User user;

  const _UserInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        children: [

          CircleAvatar(
            backgroundColor: colors.onSecondary,
            radius: 47,
            child: Icon(
              user.role.icon,
              size: 57,
              color: colors.primary,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            user.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),

          Text('ID: ${user.id}', style: const TextStyle(fontSize: 14)),

          Text(
            'Rol: ${user.role.label}',
            style: const TextStyle(fontSize: 14),
          ),

          Text('Email: ${user.email}', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

