class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  /// Convert Dart object → JSON
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
