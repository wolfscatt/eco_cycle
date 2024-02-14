import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_repository.dart';
import '../user_repository/user_repository.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
    String? error =
        await _authRepo.loginUserWithEmailAndPassword(email, password);
    _authRepo.setInitialScreen(_authRepo.firebaseUser.value);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: Duration(seconds: 3),
      ));
    } else {
      final user = await _userRepo.getUserDetails(email);
      Helper.successSnackBar(title: "${user.fullName} Logged", message: "Login Successful");
    }
  }

  Future<void> googleSignIn() async {
    try {
      await _authRepo.signInWithGoogle();
      final user = _authRepo.firebaseUser.value;
      _authRepo.setInitialScreen(user);
      Helper.successSnackBar(title: "${user?.displayName ?? "User"} Logged", message: "Login Successful");
    } catch (e) {
      Helper.errorSnackBar(
          title: "Google Sign In Failed", message: e.toString());
    }
  }
}
