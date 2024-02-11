
import 'package:eco_cycle/src/utils/constants.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            image: const AssetImage(logoImage), width: 200, height: 200),
        Text(welcomeText, style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}