import 'package:eco_cycle/src/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_cycle/src/utils/theme/theme.dart';

void main() {
  runApp(Deneme());
}

class Deneme extends StatelessWidget {
  final String title = "Demo App";
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

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
