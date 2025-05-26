import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/users_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>((ref) {
  final repository = ref.watch(usersRepositoryProvider);
  return UsersNotifier(
    fetchUsers: repository.getUsers,
  );
});
typedef UserCallback = Future<List<User>> Function();

class UsersNotifier extends StateNotifier<List<User>> {
  bool isLoading = false;
  final UserCallback fetchUsers;

  UsersNotifier({
    required this.fetchUsers,
  }) : super([]);

  Future<void> loadUsers() async {

    if (isLoading) return;
    
    isLoading = true;
    
    final List<User> users = await fetchUsers();
    state.clear();
    state = [...users];
    
    isLoading = false;
  }

}