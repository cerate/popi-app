import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/auth_api.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/data/user_local_data_source.dart';
import '../../features/auth/domain/user.dart';
import 'network_provider.dart';
import 'storage_provider.dart';
import '../type/user_type.dart';

final userProvider =
    NotifierProvider<UserController, User?>(UserController.new);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    api: AuthApi(ref.watch(dioProvider)),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

final userStatusProvider = Provider<UserStatus>((ref) {
  return ref.watch(userProvider) == null
      ? UserStatus.guest
      : UserStatus.authenticated;
});

class UserController extends Notifier<User?> {
  @override
  User? build() => ref.read(userLocalDataSourceProvider).read();

  Future<void> setUser(User user) async {
    state = user;
    await ref.read(userLocalDataSourceProvider).write(user);
  }

  Future<void> signIn({required String email, required String password}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    await setUser(user);
  }

  Future<void> updateUser(
      {String? name, String? email, String? avatarUrl}) async {
    final currentUser = state;
    if (currentUser == null) return;
    await setUser(
      currentUser.copyWith(name: name, email: email, avatarUrl: avatarUrl),
    );
  }

  Future<void> clearUser() async {
    state = null;
    await ref.read(userLocalDataSourceProvider).clear();
    await ref.read(authRepositoryProvider).logout();
  }
}
