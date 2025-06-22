import 'package:flutter/material.dart';
enum UserRole { admin, client, technician }

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role; 

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

extension UserCopy on User {
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    UserRole? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}

// ===== UserRole Extensions =====

extension UserRoleX on UserRole {
  static UserRole fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'client':
        return UserRole.client;
      case 'technician':
        return UserRole.technician;
      default:
        throw ArgumentError('Unknown user role: $role');
    }
  }
}

extension UserRoleLabel on UserRole {
  String get label {
    switch (this) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.client:
        return 'Cliente';
      case UserRole.technician:
        return 'Técnico';
    }
  }
}

extension UserRoleColor on UserRole {
  Color get color {
    switch (this) {
      case UserRole.admin:
        return Colors.deepPurple.shade200;
      case UserRole.client:
        return Colors.blue.shade200;
      case UserRole.technician:
        return Colors.green.shade200;
    }
  }
}

extension UserRoleIcon on UserRole {
  IconData get icon {
    switch (this) {
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.client:
        return Icons.person;
      case UserRole.technician:
        return Icons.build;
    }
  }
}