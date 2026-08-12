class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  User copyWith({
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode => Object.hash(id, name, email, avatarUrl);
}
