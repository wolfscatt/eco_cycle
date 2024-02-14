class RegisterWithEmailAndPasswordFailure implements Exception {
  final String message;

  const RegisterWithEmailAndPasswordFailure([this.message = "Error creating account"]);

  factory RegisterWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "email-already-in-use":
        return const RegisterWithEmailAndPasswordFailure("Email already in use");
      case "invalid-email":
        return const RegisterWithEmailAndPasswordFailure("Invalid email address");
      case "operation-not-allowed":
        return const RegisterWithEmailAndPasswordFailure("Operation not allowed");
      case "weak-password":
        return const RegisterWithEmailAndPasswordFailure("Weak password");
      case "too-many-requests":
        return const RegisterWithEmailAndPasswordFailure("Too many requests");
      case "user-disabled":
        return const RegisterWithEmailAndPasswordFailure("User disabled");
      case "user-not-found":
        return const RegisterWithEmailAndPasswordFailure("User not found");
      case "wrong-password":
        return const RegisterWithEmailAndPasswordFailure("Wrong password");
      case "user-already-exists":
        return const RegisterWithEmailAndPasswordFailure("User already exists");
      default:
        return const RegisterWithEmailAndPasswordFailure();
    }
  }
}