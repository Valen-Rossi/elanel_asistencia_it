import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';

final currentAppUserProvider = Provider<User?>((ref) {
  final authUser = ref.watch(authStateProvider).asData?.value;
  final allUsers = ref.watch(usersProvider);

  if (authUser == null) return null;

  return allUsers.firstWhere(
    (u) => u.id == authUser.uid,
  );
});
