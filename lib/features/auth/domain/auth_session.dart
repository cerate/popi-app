import 'user.dart';

class AuthSession {
  const AuthSession({required this.user, required this.accessToken});

  final User user;
  final String accessToken;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
    );
  }
}
