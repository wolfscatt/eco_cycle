import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_cycle/src/domain/entities/photograf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'exceptions/register_email_password_failure.dart';

class PhotoRepository extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<String?> uploadImageCloud(AddedPhotoData addedPhotoData) async {
    try {
      await _db.collection('Photos').add(addedPhotoData.toJson());
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
  }

  Future<List<AddedPhotoData>> readImageFromCloud() async {
    try {
      final snapshot = await _db.collection('Photos').get();
      print(snapshot);
      return snapshot.docs
          .map((doc) => AddedPhotoData.fromJson(doc.data()))
          .toList();
    } catch (error) {
      final err = error.toString();
      throw err;
    }
  }

  Future<String?> deleteImageFromCloud(String imageId) async {
    try {
      final image = await _db.collection('Photos').where('imageId', isEqualTo: imageId).get();
      image.docs.forEach((element) {
        element.reference.delete();
      });
    } catch (error) {
      final err = RegisterWithEmailAndPasswordFailure.code(error.toString());
      return err.message;
    }
    return null;
  }
}
