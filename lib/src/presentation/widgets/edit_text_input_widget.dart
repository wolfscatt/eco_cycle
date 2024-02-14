import 'package:eco_cycle/src/domain/repositories/profile_controller.dart';
import 'package:flutter/material.dart';

class EditTextInputWidget extends StatelessWidget {
  const EditTextInputWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,
    this.initialValue, 
    required this.controller,
  });

  final TextEditingController controller;
  final String? initialValue;
  final String labelText;
  final String hintText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        controller: controller,
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
