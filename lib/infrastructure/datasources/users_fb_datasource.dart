import 'package:elanel_asistencia_it/domain/datasources/users_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';

class UsersFbDatasource extends IUsersDatasource {

  List<User> users = [
    
    User(
      id: '001',
      name: 'Lautaro Rodríguez',
      email: 'tintin@gmail.com',
      role: UserRole.admin,
    ),

    User(
      id: '002',
      name: 'Ana Gómez',
      email: 'ana@gmail.com',
      role: UserRole.technician,
    ),

    User(
      id: '003',
      name: 'Luis Fernández',
      email: 'luis@gmail.com',
      role: UserRole.client,
    ),

    User(
      id: '004',
      name: 'María López',
      email: 'mari@gmail.com',
      role: UserRole.client,
    ),

    User(
      id: '005',
      name: 'Carlos Sánchez',
      email: 'carlos@gmail.com',
      role: UserRole.technician,
    ),

    User(
      id: '006',
      name: 'Valentino Rossi',
      email: 'rossi@gmail.com',
      role: UserRole.admin,
    ),

    User(
      id: '007',
      name: 'Julián Álvarez',
      email: 'araña@gmail.com',
      role: UserRole.technician,
    ),

    User(
      id: '008',
      name: 'Lionel Messi',
      email: 'pulga@gmail.com',
      role: UserRole.technician,
    ),

  ];

  @override
  Future<List<User>> getUsers() async{
    // TODO: implement getUsers
    return users;
  }

  @override
  Future<void> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}