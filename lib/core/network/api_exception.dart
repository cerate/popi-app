import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiException.fromDioException(DioException exception) {
    return ApiException(
      message: exception.message ?? 'Network request failed',
      statusCode: exception.response?.statusCode,
    );
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
