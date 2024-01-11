import 'package:covoiturage/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final TextStyle lightText = GoogleFonts.nunito(
    textStyle: const TextStyle(
      color: AppColors.blackTextColor,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0XFF008955),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(toolbarTextStyle: lightText),
    textTheme: TextTheme(
      bodyLarge: lightText,
      bodyMedium: lightText,
      labelLarge: lightText,
      bodySmall: lightText,
      labelSmall: lightText,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    navigationBarTheme: const NavigationBarThemeData(
      // indicatorColor: AppColors.backgroundColor,
      indicatorColor: AppColors.whiteColor,
    ),
    // colorScheme: const ColorScheme(background: AppColors.backgroundColor),
  );
}
