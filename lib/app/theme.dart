import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF356859),
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }
}
