import 'package:elanel_asistencia_it/infrastructure/datasources/users_fb_datasource.dart';
import 'package:elanel_asistencia_it/infrastructure/repositories/users_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersRepositoryProvider = Provider((ref) {
  return UsersRepositoryImpl(UsersFbDatasource());
});