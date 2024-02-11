
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

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