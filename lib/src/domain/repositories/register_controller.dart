import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/repositories/user_repository/user_repository.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  // final AuthenticationRepository _authRepo = Get.put(AuthenticationRepository());

  final fullName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> registerUser(String email, String? password) async {
    String? error = await AuthenticationRepository.to
        .createUserWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      final auth = AuthenticationRepository.to;
      await userRepo.createUser(user);
      registerUser(user.email, user.password);
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      print(e);
    }
  }

  void phoneAuth(String text) {
    AuthenticationRepository.to.phoneAuth(text);
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
