import 'package:dio/dio.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/storage/secure_storage.dart';
import '../domain/user.dart';
import 'auth_api.dart';

class AuthRepository {
  const AuthRepository({required this.api, required this.secureStorage});

  final AuthApi api;
  final TokenStorage secureStorage;

  Future<User> login({required String email, required String password}) async {
    try {
      final session = await api.login(email: email, password: password);
      await secureStorage.writeAccessToken(session.accessToken);
      return session.user;
    } on DioException catch (exception) {
      throw ApiException.fromDioException(exception);
    }
  }

  Future<User> fetchCurrentUser() async {
    try {
      return await api.currentUser();
    } on DioException catch (exception) {
      throw ApiException.fromDioException(exception);
    }
  }

  Future<void> logout() => secureStorage.deleteAccessToken();
}
