class LoginException implements Exception {
  final String message;

  const LoginException([this.message = "Error Sign In account"]);

  factory LoginException.code(String code) {
    switch (code) {
      case "invalid-email":
        return const LoginException("Invalid email address");
      case "operation-not-allowed":
        return const LoginException("Operation not allowed");
      case "weak-password":
        return const LoginException("Weak password");
      default:
        return const LoginException();
    }
  }
}