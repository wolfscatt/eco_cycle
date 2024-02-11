import 'package:eco_cycle/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: AppTextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(0xFF00202b, <int, Color>{
      50: Color(0xFFE8EAF6),
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5),
      600: Color(0xFF394AAE),
      700: Color(0xFF3140A5),
      800: Color(0xFF29379D),
      900: Color(0xFF1A237E),
    })),
  );
}
