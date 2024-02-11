import 'package:eco_cycle/src/presentation/widgets/header_widget.dart';
import 'package:eco_cycle/src/utils/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              HeaderWidget(),
              RegisterForm(),
              RegisterFooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

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
                  border: OutlineInputBorder()
              )
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "E-Mail",
                  hintText: "Enter E-Mail Address",
                  border: OutlineInputBorder() 
                  ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder() 
                  ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: "Password",
                  hintText: "Enter Password",
                  border: OutlineInputBorder(), 
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

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text("Sign In With Google".toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "Already Have An Account ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(text: "Login".toUpperCase())
          ])),
        )
      ],
    );
  }
}