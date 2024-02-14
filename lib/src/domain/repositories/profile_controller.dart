import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/repositories/user_repository/user_repository.dart';
import 'package:eco_cycle/src/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final RxBool obsecureText = true.obs;

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  signOut(){
    _authRepo.signOut();
  }

  deleteUser(UserModel user) async {
    await _userRepo.deleteUser(user);
    Get.snackbar("Success", "Account deleted successfully");
  }

  updateUser(UserModel user, String? id) async {
    try {
      await _userRepo.updateUser(user, id);
      Get.snackbar('Success', 'User Updated Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green);
      Get.off(ProfilePage());
    } catch (error) {
      Get.snackbar('Error', 'Something went wrong, please try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    }
  }
}
