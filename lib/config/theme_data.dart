import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//App colors

class AppColors {
  static const Color green = Color(0xff307A59);
  static const Color black = Color(0xff3E3E3E);
  static const Color white = Colors.white;
  static const Color grey = Color(0xff3E4958);
  static const Color lightGreen = Color(0xffACCABD);
  static const Color lightGrey = Color(0xffBBBBBB);
  static const Color red = Color(0xffFF1F1F);

  AppColors();
}

var lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff307A59),
  brightness: Brightness.light,
);

final themeData = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  textTheme: GoogleFonts.interTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
  ),
  scaffoldBackgroundColor: AppColors.white,
);
