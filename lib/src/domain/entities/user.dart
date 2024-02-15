import 'package:cloud_firestore/cloud_firestore.dart';

import 'photograf.dart';

class UserModel implements BaseUser {
  final String? id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? password;
  final String? photoURL;
  final int? points;
  final AddedPhotoData? addedPhotoData;

  UserModel( 
      {this.id,
      required this.fullName,
      required this.email,
      this.phoneNumber,
      this.password,
      this.photoURL,
      this.points,
      this.addedPhotoData
      });

// JSON'dan User nesnesine dönüştürme metodu
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data['fullName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      password: data['password'],
      photoURL: data['photoURL'],
      points: data['points'],
      addedPhotoData: AddedPhotoData(
        id: data['addedPhotoData']['id'],
        name: data['addedPhotoData']['name'],
        imageUri: data['addedPhotoData']['imageUri'],
        category: data['addedPhotoData']['category'],
        description: data['addedPhotoData']['description'],
      ),
    );
  }

  // User nesnesini JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'photoURL': photoURL,
      'points': points,
      'addedPhotoData': {
        'id': addedPhotoData?.id,
        'name': addedPhotoData?.name,
        'imageUri': addedPhotoData?.imageUri,
        'category': addedPhotoData?.category,
        'description': addedPhotoData?.description,
      },
    };
  }
}

abstract class BaseUser {}
