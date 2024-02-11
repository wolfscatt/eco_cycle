import 'package:eco_cycle/src/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_cycle/src/utils/theme/theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: WelcomeScreen(),
    );
  }
}

