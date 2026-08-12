import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/preferences_storage.dart';
import '../../../shared/providers/storage_provider.dart';
import '../domain/user.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>(
  (ref) => UserLocalDataSource(ref.watch(preferencesStorageProvider)),
);

class UserLocalDataSource {
  const UserLocalDataSource(this.storage);

  static const storageKey = 'current_user';
  final PreferencesStorage storage;

  User? read() {
    final rawUser = storage.getString(storageKey);
    if (rawUser == null) return null;

    try {
      return User.fromJson(jsonDecode(rawUser) as Map<String, dynamic>);
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    }
  }

  Future<void> write(User user) {
    return storage.setString(storageKey, jsonEncode(user.toJson()));
  }

  Future<void> clear() => storage.remove(storageKey);
}
