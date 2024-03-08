import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

//light theme color scheme
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.green,
);

//app general theme data
final themeData = ThemeData(
    colorScheme: lightColorScheme,
    textTheme: GoogleFonts.interTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade100,
      // foregroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      shape: const CircleBorder(),
    ));
