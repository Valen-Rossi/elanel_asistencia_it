import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/user_firebase.dart';

class UserMapper {
  static User toEntity(UserFromFirebase fb) {
    return User(
      id: fb.id,
      name: fb.name,
      email: fb.email,
      password: fb.password,
      role: UserRoleX.fromString(fb.role),
    );
  }

  static UserFromFirebase toFirebase(User u) {
    return UserFromFirebase(
      id: u.id,
      name: u.name,
      email: u.email,
      password: u.password,
      role: u.role.name,
    );
  }
}