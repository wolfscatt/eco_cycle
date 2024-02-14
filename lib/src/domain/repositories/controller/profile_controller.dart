import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/repositories/user_repository/user_repository.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:eco_cycle/src/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../entities/user.dart';

class ProfileController extends GetxController{
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

  signOut(UserModel? user) async {
    _authRepo.signOut();
    if(user != null) {
      Helper.warningSnackBar(
        title: "${user.fullName} Sign Out", message: "User Sign Out Successfully");
    }
  }

  deleteUser(String id) async {
    await _userRepo.deleteUser(id);
    await _authRepo.deleteUser();
    final user = _authRepo.firebaseUser.value;
    Helper.errorSnackBar(
        title: "${user?.displayName ?? "User"} Deleted", message: "User Deleted Successfully");
  }

  updateUser(UserModel user, String? id) async {
    try {
      await _userRepo.updateUser(user, id);
      Helper.successSnackBar(
          title: "Success", message: "User Updated Successfully");
      Get.offAll(ProfilePage());
    } catch (error) {
      Helper.errorSnackBar(
          title: "Error", message: "Something went wrong, please try again");
      print(error.toString());
    }
  }
}
