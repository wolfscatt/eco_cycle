import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_repository.dart';

class LoginController extends GetxController{
  static LoginController get to => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
    String? error = await AuthenticationRepository.to.loginUserWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),duration: Duration(seconds: 3),));
    }
  }
}