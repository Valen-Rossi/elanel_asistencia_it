import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        colorSchemeSeed: const Color(0xff027cf1),
      );

  ThemeData getDarkTheme() => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff027cf1),
          brightness: Brightness.dark,
        ),
      );
}
