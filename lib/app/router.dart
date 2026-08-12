import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/presentation/chat_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/settings/presentation/settings_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
    ],
  );
});
