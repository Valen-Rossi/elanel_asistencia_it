import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:elanel_asistencia_it/domain/datasources/users_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/infrastructure/mappers/user_mapper.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/user_firebase.dart';


class UsersFbDatasource extends IUsersDatasource {

  final _db = FirebaseFirestore.instance.collection('users');
  final _functions = FirebaseFunctions.instanceFor(region: 'southamerica-east1');

  @override
  Future<List<User>> getUsers() async{
    final snap = await _db.get();
    return snap.docs
        .map((d) => UserMapper.toEntity(
            UserFromFirebase.fromJson(d.id, d.data())))
        .toList();
    }

   @override
  Future<void> addUser(User user) async {
    try {
      await _functions
        .httpsCallable('createUserWithProfile')
        .call({
          'email': user.email,
          'password': user.password,
          'displayName': user.name,
          'role': user.role.name,
          'phone': '',
        });

      // final result = await _functions
      //     .httpsCallable('createUserWithProfile')
      //     .call({
      //       'email': user.email,
      //       'password': user.password,
      //       'displayName': user.name,
      //       'role': user.role.name,
      //       'phone': '',
      //     });

      // final uid = result.data['uid'];

      // // opcional: podés guardar localmente el uid si lo necesitás
      // print('Usuario creado con UID: $uid');

    } on FirebaseFunctionsException catch (e) {
      // print("Error creando usuario: ${e.code} - ${e.message}");
      throw Exception("No se pudo crear el usuario");
    }
  }

  @override
  Future<void> deleteUser(String id) async{
    await _db.doc(id).delete();
  }

  @override
  Future<void> updateUser(User user) async{
    final fb = UserMapper.toFirebase(user);
    await _db.doc(user.id).update(fb.toJson());
  }

}