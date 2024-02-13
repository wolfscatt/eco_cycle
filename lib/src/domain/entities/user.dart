class UserModel implements BaseUser {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  UserModel(
      {this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password});

// JSON'dan User nesnesine dönüştürme metodu
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }

  // User nesnesini JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}

abstract class BaseUser {}
