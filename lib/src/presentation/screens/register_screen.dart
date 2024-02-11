import 'package:eco_cycle/src/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/register/register_footer_widget.dart';
import '../widgets/register/register_form_widget.dart';

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

