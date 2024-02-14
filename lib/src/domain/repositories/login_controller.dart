import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_repository.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
    try {
      final auth = AuthenticationRepository.to;
      String? error = await AuthenticationRepository.to
          .loginUserWithEmailAndPassword(email, password);
          auth.setInitialScreen(auth.firebaseUser.value);
      if (error != null) {
        Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleSignIn() async {
    try {
      final auth = AuthenticationRepository.to;
      await auth.signInWithGoogle();
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      Helper.errorSnackBar(title: "Google Sign In Failed", message: e.toString());
    }
  }
}
