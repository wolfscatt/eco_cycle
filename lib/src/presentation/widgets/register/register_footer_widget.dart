import 'package:eco_cycle/src/domain/repositories/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../screens/login_screen.dart';

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              controller.googleSignIn();
            },
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text("Sign In With Google".toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            Get.to(() => LoginScreen());
          },
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
