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
      default:
        return const RegisterWithEmailAndPasswordFailure();
    }
  }
}