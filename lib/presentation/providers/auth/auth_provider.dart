import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Proveedor de la instancia de FirebaseAuth
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

// Proveedor de estado del usuario autenticado
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});
