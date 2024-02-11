import 'package:flutter/material.dart';

class AppTextFormFieldTheme{

  static InputDecorationTheme lightInputDecorationTheme = 
  const InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepOrange,
          width: 2,
        ),
      ),
  );

   static InputDecorationTheme darkInputDecorationTheme = 
  const InputDecorationTheme(
      border: OutlineInputBorder(),
      prefixIconColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
  );
}