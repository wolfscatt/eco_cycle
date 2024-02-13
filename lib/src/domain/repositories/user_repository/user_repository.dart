import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_user_repository.dart';

class UserRepository extends GetxController implements BaseUserRepository {
  static UserRepository get to => Get.find();

  final _db = FirebaseFirestore.instance;

  //@override
  // createUser(UserModel user) async{
  //   await _db
  //       .collection('Users')
  //       .add(user.toJson())
  //       .whenComplete(() => Get.snackbar('Success', 'User created successfully',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.green.withOpacity(0.1),
  //           colorText: Colors.green))
  //       .catchError((error, stackTrace) {
  //     Get.snackbar('Error', 'Something went wrong, please try again',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red);
  //       print(error.toString());
  //   });
  // }
  @override
Future<void> createUser(UserModel user) async {
  try {
    await _db
        .collection('Users')
        .add(user.toJson());
    Get.snackbar('Success', 'User created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green);
  } catch (error, stackTrace) {
    Get.snackbar('Error', 'Something went wrong, please try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red);
    print(error.toString());
  }
}
}
