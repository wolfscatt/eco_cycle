import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/repositories/user_repository/user_repository.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../entities/user.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  final fullName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  Future<void> registerUser(String email, String? password) async {
    String? error =
        await _authRepo.createUserWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: Duration(seconds: 3),
      ));
    } 
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _userRepo.createUser(user);
      registerUser(user.email, user.password);
      final userFirebase = _authRepo.firebaseUser.value;
      _authRepo.setInitialScreen(userFirebase);
      Helper.successSnackBar(
          title: "${user.fullName} Created",
          message: "User Created Successfully");
    } catch (e) {
      print(e);
      Helper.errorSnackBar(title: "User Not Created", message: e.toString());
    }
  }

  void phoneAuth(String text) {
    _authRepo.phoneAuth(text);
  }

  Future<void> googleSignIn() async {
    try {
      await _authRepo.signInWithGoogle();
      final user = _authRepo.firebaseUser.value;
      _authRepo.setInitialScreen(user);
      Helper.successSnackBar(
          title: "${user?.displayName ?? "User"} Logged",
          message: "Login Successful");
    } catch (e) {
      Helper.errorSnackBar(
          title: "Google Sign In Failed", message: e.toString());
    }
  }
}
