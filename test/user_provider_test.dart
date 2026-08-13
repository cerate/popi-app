import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:popi_ai_app/core/storage/secure_storage.dart';
import 'package:popi_ai_app/shared/providers/storage_provider.dart';
import 'package:popi_ai_app/features/auth/domain/user.dart';
import 'package:popi_ai_app/shared/providers/user_provider.dart';

void main() {
  const user = User(id: '1', name: '张三', email: 'test@example.com');

  test('persists and restores the current user', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        secureStorageProvider.overrideWithValue(_MemoryTokenStorage()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(userProvider.notifier).setUser(user);
    expect(container.read(userProvider), user);

    final restoredContainer = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        secureStorageProvider.overrideWithValue(_MemoryTokenStorage()),
      ],
    );
    addTearDown(restoredContainer.dispose);
    expect(restoredContainer.read(userProvider), user);
  });

  test('clears the current user', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        secureStorageProvider.overrideWithValue(_MemoryTokenStorage()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(userProvider.notifier).setUser(user);
    await container.read(userProvider.notifier).clearUser();

    expect(container.read(userProvider), isNull);
    expect(preferences.getString('current_user'), isNull);
  });
}

class _MemoryTokenStorage implements TokenStorage {
  String? token;

  @override
  Future<String?> readAccessToken() async => token;

  @override
  Future<void> writeAccessToken(String value) async => token = value;

  @override
  Future<void> deleteAccessToken() async => token = null;
}
