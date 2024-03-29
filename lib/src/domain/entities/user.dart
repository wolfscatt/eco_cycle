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

  UserModel( 
      {this.id,
      required this.fullName,
      required this.email,
      this.phoneNumber,
      this.password,
      this.photoURL,
      this.points,
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
      
    };
  }
}

abstract class BaseUser {}
