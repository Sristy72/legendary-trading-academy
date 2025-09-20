import 'package:flutter_ladydenily/features/auth/data/models/user_model.dart';

class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String role;
  final String id;
  final UserModel user;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.id,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json["accessToken"] ?? "",
      refreshToken: json["refreshToken"] ?? "",
      role: json["role"] ?? "",
      id: json["_id"] ?? "",
      user: UserModel.fromJson(json["user"] ?? {}),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "accessToken": accessToken,
  //     "refreshToken": refreshToken,
  //     "role": role,
  //     "_id": id,
  //     "user": user.toJson(),
  //   };
  // }
}