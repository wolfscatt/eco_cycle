import 'package:flutter/material.dart';

class AppTextTheme{
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );
  
}