import 'package:eco_cycle/src/presentation/screens/login_screen.dart';
import 'package:eco_cycle/src/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:eco_cycle/src/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  final welcomeText = 'Welcome to Eco Cycle';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF00202b),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
                image: AssetImage(logoImage), width: 200, height: height * 0.4),
            Text(welcomeText, style: Theme.of(context).textTheme.headlineLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          print("Login");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: Text('Login'.toUpperCase()))),
                SizedBox(width: 30),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          print("Register");
                           Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text('Register'.toUpperCase()))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
