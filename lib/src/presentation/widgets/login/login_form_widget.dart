import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../forget_password/forget_password_model_bottom.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var email = mailController.text;
    var password = passwordController.text;
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: mailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "E-Mail",
                hintText: "Enter E-Mail Address",
              ),
              onChanged: (value) {
                setState(() {
                  mailController.text = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Enter Password",
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  passwordController.text = value;
                });
              },
            ),

            const SizedBox(height: 10),
            // -- Forget Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgetPasswordScreen.buildShowModalBottomSheet(
                        theme, context);
                  },
                  child: const Text("Forget Password")),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Login HomePage");
                  print("Email: $email\nPassword: $password");
                  //if (email == "omer@gmail.com" && password == "12345") {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Login".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
