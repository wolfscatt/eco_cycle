import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/src/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_user_repository.dart';

class UserRepository extends GetxController implements BaseUserRepository {
  static UserRepository get to => Get.find();

  final _db = FirebaseFirestore.instance;

// CRUD Operations
// Create User
  @override
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').add(user.toJson());
      Get.snackbar('Success', 'User created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green);
    } catch (error) {
      Get.snackbar('Error', 'Something went wrong, please try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    }
  }

  Future<void> addGoogleUser(User user) async {
    try {
      await _db.collection("Users").add({
        "email": user.email,
        "fullName": user.displayName,
        "phoneNumber": user.phoneNumber,
        "photoURL": user.photoURL,
      });
    } catch (e) {
      print(e);
    }
  }

  // Read User
  @override
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // Update User
  @override
  Future<void> updateUser(UserModel user, String? id) async {
    await _db.collection("Users").doc(id).update(user.toJson());
  }

  // Delete User
  @override
  Future<void> deleteUser(UserModel user) async {
    await _db.collection("Users").doc(user.id).delete();
  }
}
