import 'package:eco_cycle/src/domain/repositories/login_controller.dart';
import 'package:eco_cycle/src/domain/repositories/register_controller.dart';
import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../forget_password/forget_password_model_bottom.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "E-Mail",
                hintText: "Enter E-Mail Address",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: obsecureText,
              controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Enter Password",
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye_sharp),
                  onPressed: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                ),
              ),
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
                  if (controller.loginFormKey.currentState!.validate()) {
                    LoginController.to
                        .login(controller.email.text, controller.password.text);
                  }
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
