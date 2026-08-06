import 'package:flutter/material.dart';

/// App-wide Material 3 theme, built around Vazirmatn and a seed color.
/// Locale/RTL is handled by [MaterialApp], not here.
ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D6B));

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    fontFamily: 'Vazirmatn',
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surfaceContainerHigh,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontFamily: 'Vazirmatn'),
      ),
    ),
  );
}
