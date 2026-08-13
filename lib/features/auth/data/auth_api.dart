import 'package:dio/dio.dart';

import '../domain/auth_session.dart';
import '../domain/user.dart';

class AuthApi {
  const AuthApi(this.dio);

  final Dio dio;

  Future<AuthSession> login(
      {required String email, required String password}) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthSession.fromJson(response.data!);
  }

  Future<User> currentUser() async {
    final response = await dio.get<Map<String, dynamic>>('/auth/me');
    return User.fromJson(response.data!);
  }
}
