import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/users_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final technicianUsersProvider = Provider<List<User>>((ref) {
  final users = ref.watch(usersProvider);
  return users.where((user) => user.role == UserRole.technician).toList();
});