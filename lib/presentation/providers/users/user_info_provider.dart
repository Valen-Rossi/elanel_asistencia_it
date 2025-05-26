import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:collection/collection.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/users_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userByIdProvider = Provider.family<User, String>((ref, userId) {
  final users = ref.watch(usersProvider);
  return users.firstWhere((user) => user.id == userId);
});