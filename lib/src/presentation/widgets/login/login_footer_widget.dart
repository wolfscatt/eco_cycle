
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../screens/register_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(googleLogo), width: 20.0),
            onPressed: () {},
            label: const Text("Sign In With Google"),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
            Get.to(() => RegisterScreen());
          },
          child: Text.rich(
            TextSpan(
                text: "Don't Have An Account",
                style: Theme.of(context).textTheme.bodySmall,
                children: const [
                  TextSpan(text: " Sign Up", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}