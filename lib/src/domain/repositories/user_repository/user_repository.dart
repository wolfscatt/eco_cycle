import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/src/domain/entities/user.dart';
import 'package:eco_cycle/src/domain/repositories/auth_repository.dart';
import 'package:eco_cycle/src/domain/repositories/exceptions/register_email_password_failure.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
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
  Future<String?> createUser(UserModel user) async {
    try {
      final existingUsers = await _db
          .collection("Users")
          .where("email", isEqualTo: user.email)
          .get();
      if (existingUsers.docs.isNotEmpty) {
        // Eğer kullanıcı zaten varsa eklemeyi yapma
        print("User already exists");
        Helper.warningSnackBar(
            title: "${user.email} already exists",
            message: "User already exists");
        return RegisterWithEmailAndPasswordFailure.code("user-already-exists")
            .message;
      }
      await _db.collection('Users').add(user.toJson());
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
  }

  Future<String?> addGoogleUser(User user) async {
    try {
      final existingUsers = await _db
          .collection("Users")
          .where("email", isEqualTo: user.email)
          .get();
      if (existingUsers.docs.isNotEmpty) {
        // Eğer kullanıcı zaten varsa eklemeyi yapma
        print("User already exists");
        return RegisterWithEmailAndPasswordFailure.code("user-already-exists")
            .message;
      }
      await _db.collection("Users").add({
        "email": user.email,
        "fullName": user.displayName,
        "phoneNumber": user.phoneNumber,
        "photoURL": user.photoURL,
      });
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
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
  Future<String?> updateUser(UserModel user, String? id) async {
    try {
      await _db.collection("Users").doc(id).update(user.toJson());
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
  }

  // Delete User
  @override
  Future<String?> deleteUser(String id) async {
    try {
      await _db.collection("Users").doc(id).delete();
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
  }
  
  @override
  Future<UserModel> getUserName(UserModel user) async {
    final snapshot = await _db.collection("Users").where("fullName", isEqualTo: user.fullName).get();
    return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    
  }
}
