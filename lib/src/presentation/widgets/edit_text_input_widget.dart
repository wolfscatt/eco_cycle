import 'package:flutter/material.dart';

class EditTextInputWidget extends StatelessWidget {
  const EditTextInputWidget({
    super.key, 
    required this.labelText, 
    required this.hintText, 
    required this.iconData,
  });

  final String labelText;
  final String hintText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // controller: controller.fullName,
        decoration: InputDecoration(
      prefixIcon: Icon(iconData),
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ));
  }
}
