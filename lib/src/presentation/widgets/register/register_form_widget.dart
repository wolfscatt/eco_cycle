
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  labelText: "Full Name",
                  hintText: "Enter Full Name",
              )
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "E-Mail",
                  hintText: "Enter E-Mail Address",
                  ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: "Password",
                  hintText: "Enter Password",
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sign Up".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}