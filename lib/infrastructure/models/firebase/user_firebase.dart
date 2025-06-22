import 'package:elanel_asistencia_it/domain/entities/user.dart';

class UserFromFirebase {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role; 

  UserFromFirebase({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  factory UserFromFirebase.fromJson(String id, Map<String, dynamic> json) {
    return UserFromFirebase(
      id: id,
      name: json['displayName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? UserRole.client.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }
  
}