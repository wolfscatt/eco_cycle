import 'package:eco_cycle/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/repositories/controller/register_controller.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  labelText: "Full Name",
                  hintText: "Enter Full Name",
                )),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "E-Mail",
                hintText: "Enter E-Mail Address",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.numbers),
                labelText: "Phone Number",
                hintText: "Enter Phone Number",
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ----------- Create User -----------
                    createUserAndSignUp(controller);
                  }
                },
                child: Text("Sign Up".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void createUserAndSignUp(RegisterController controller) {
  final user = UserModel(
      fullName: controller.fullName.text.trim(),
      email: controller.email.text.trim(),
      phoneNumber: '+90${controller.phoneNumber.text.trim()}',      // düzenlenebilir.
      password: controller.password.text.trim());
  controller.createUser(user);
}
