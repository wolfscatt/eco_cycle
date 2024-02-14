import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../domain/repositories/controller/mail_verification_controller.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LineAwesomeIcons.envelope_open, size: 100),
                SizedBox(height: 20),
                Text(
                  "Please verify your email address",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 20),
                Text(
                  "We have sent a verification link to your email address. Please click on the link to verify your email address.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 200,
                    child: OutlinedButton(
                        onPressed: () {
                          controller.manuallyCheckEmailVerificationStatus();
                        }, child: Text("Continue"))),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      controller.sendVerificationMail();
                    }, child: Text("Resend Verification Link")),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("I have verified my email address"),
                        Icon(LineAwesomeIcons.check_circle)
                      ],
                    )),
                    ElevatedButton(onPressed: 
                    (){
                      Get.find<AuthenticationRepository>().signOut();
                    }, child: Text("Sign Out")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
