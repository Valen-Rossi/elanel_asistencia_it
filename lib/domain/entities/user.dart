enum UserRole { admin, client, technician }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role; 

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
// ===== UserRole Extensions =====
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
