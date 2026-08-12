import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this.storage);

  final TokenStorage storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
