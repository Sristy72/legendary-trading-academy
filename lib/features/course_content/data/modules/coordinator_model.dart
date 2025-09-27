import 'avarter_module.dart';
import 'treding_profile_model.dart';
import 'user_rating_module.dart';
import 'verification_module.dart';

class Coordinator {
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String role;
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TredingProfile tredingProfile;
  final bool tredingProfileComplete;

  Coordinator({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.role,
    required this.avatar,
    required this.verificationInfo,
    required this.userRating,
    required this.tredingProfile,
    required this.tredingProfileComplete,
  });

  factory Coordinator.fromJson(Map<String, dynamic> json) => Coordinator(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    phone: json["phone"],
    role: json["role"],
    avatar: Avatar.fromJson(json["avatar"]),
    verificationInfo: VerificationInfo.fromJson(json["verificationInfo"]),
    userRating: UserRating.fromJson(json["userRating"]),
    tredingProfile: TredingProfile.fromJson(json["treding_profile"]),
    tredingProfileComplete: json["treding_profile_Complete"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "username": username,
    "phone": phone,
    "role": role,
    "avatar": avatar.toJson(),
    "verificationInfo": verificationInfo.toJson(),
    "userRating": userRating.toJson(),
    "treding_profile": tredingProfile.toJson(),
    "treding_profile_Complete": tredingProfileComplete,
  };
}
