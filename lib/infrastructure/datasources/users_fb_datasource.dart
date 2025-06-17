import 'package:elanel_asistencia_it/domain/datasources/users_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';

class UsersFbDatasource extends IUsersDatasource {

  List<User> users = [
    
    User(
      id: '001',
      name: 'Lautaro Rodríguez',
      email: 'tintin@gmail.com',
      password: 'password001',
      role: UserRole.admin,
    ),

    User(
      id: '002',
      name: 'Ana Gómez',
      email: 'ana@gmail.com',
      password: 'password002',
      role: UserRole.technician,
    ),

    User(
      id: '003',
      name: 'Luis Fernández',
      email: 'luis@gmail.com',
      password: 'password003',
      role: UserRole.client,
    ),

    User(
      id: '004',
      name: 'María López',
      email: 'mari@gmail.com',
      password: 'password004',
      role: UserRole.client,
    ),

    User(
      id: '005',
      name: 'Carlos Sánchez',
      email: 'carlos@gmail.com',
      password: 'password005',
      role: UserRole.technician,
    ),

    User(
      id: '006',
      name: 'Valentino Rossi',
      email: 'rossi@gmail.com',
      password: 'password006',
      role: UserRole.admin,
    ),

    User(
      id: '007',
      name: 'Julián Álvarez',
      email: 'araña@gmail.com',
      password: 'password007',
      role: UserRole.technician,
    ),

    User(
      id: '008',
      name: 'Lionel Messi',
      email: 'pulga@gmail.com',
      password: 'password008',
      role: UserRole.technician,
    ),

  ];

  @override
  Future<List<User>> getUsers() async{
    // TODO: implement getUsers
    return users;
  }

  @override
  Future<void> addUser(User user) async{
    // TODO: implement addUser
    users.insert(0, user);
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