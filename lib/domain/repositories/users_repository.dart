import 'package:elanel_asistencia_it/domain/entities/user.dart';


abstract class IUsersRepository {

  Future<List<User>> getUsers();
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);

}