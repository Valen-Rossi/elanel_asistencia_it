import 'package:elanel_asistencia_it/domain/datasources/users_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends IUsersRepository {
  final IUsersDatasource datasource;

  UsersRepositoryImpl(this.datasource);
  // This class would implement the methods defined in IUsersRepository
  // For example, you might have a list of users stored in memory or fetched from a database

  @override
  Future<List<User>> getUsers() {
    // Implementation to fetch users
    return datasource.getUsers();
  }
  
  @override
  Future<void> addUser(User user) {
    // Implementation to add a user
    throw UnimplementedError('addUser method not implemented');
  }

  @override
  Future<void> updateUser(User user) {
    // Implementation to update a user
    throw UnimplementedError('updateUser method not implemented');
  }

  @override
  Future<void> deleteUser(String id) {
    // Implementation to delete a user by id
    throw UnimplementedError('deleteUser method not implemented');
  }
  
}