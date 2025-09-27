import 'package:equatable/equatable.dart';

class ApiCourse extends Equatable {
  final String id;
  final String name;
  final String description;
  final Photo? photo;
  final num price;
  final num offerPrice;
  final List<CoordinatorUser> coordinator;
  final List<Module> modules;
  final List<dynamic> enrolled;
  final int version;

  const ApiCourse({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.price,
    required this.offerPrice,
    required this.coordinator,
    required this.modules,
    required this.enrolled,
    required this.version,
  });

  factory ApiCourse.fromJson(Map<String, dynamic> json) {
    return ApiCourse(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      photo: json['photo'] != null ? Photo.fromJson(json['photo']) : null,
      price: json['price'] ?? 0,
      offerPrice: json['offerPrice'] ?? 0,
      coordinator: (json['coordinator'] as List? ?? [])
          .map((e) => CoordinatorUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      modules: (json['modules'] as List? ?? [])
          .map((e) => Module.fromJson(e as Map<String, dynamic>))
          .toList(),
      enrolled: (json['enrolled'] as List? ?? []),
      version: json['__v'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    offerPrice,
    coordinator,
    modules,
    enrolled,
    version,
  ];
}

class Photo extends Equatable {
  final String? publicId;
  final String? url;
  const Photo({this.publicId, this.url});
  factory Photo.fromJson(Map<String, dynamic> json) =>
      Photo(publicId: json['public_id'], url: json['url']);
  @override
  List<Object?> get props => [publicId, url];
}

class CoordinatorUser extends Equatable {
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TradingProfile? tradingProfile; // spelled treding_profile in API
  final dynamic age; // could be null or number/string
  final dynamic gender;
  final dynamic nationality;
  final bool tradingProfileComplete; // treding_profile_Complete
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final dynamic credit;
  final String role;
  final String stripeAccountId;
  final bool isStripeOnboarded;
  final String passwordResetToken;
  final int fine;
  final String refreshToken;
  final String uniqueId;
  final String createdAt;
  final String updatedAt;

  const CoordinatorUser({
    required this.avatar,
    required this.verificationInfo,
    required this.userRating,
    required this.tradingProfile,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.tradingProfileComplete,
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.credit,
    required this.role,
    required this.stripeAccountId,
    required this.isStripeOnboarded,
    required this.passwordResetToken,
    required this.fine,
    required this.refreshToken,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CoordinatorUser.fromJson(Map<String, dynamic> json) =>
      CoordinatorUser(
        avatar: Avatar.fromJson(json['avatar'] ?? const {}),
        verificationInfo: VerificationInfo.fromJson(
          json['verificationInfo'] ?? const {},
        ),
        userRating: UserRating.fromJson(json['userRating'] ?? const {}),
        tradingProfile: json['treding_profile'] != null
            ? TradingProfile.fromJson(json['treding_profile'])
            : null,
        age: json['age'],
        gender: json['gender'],
        nationality: json['nationality'],
        tradingProfileComplete:
            json['treding_profile_Complete'] ??
            json['treding_profile_complete'] ??
            false,
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        phone: json['phone'] ?? '',
        credit: json['credit'],
        role: json['role'] ?? '',
        stripeAccountId: json['stripeAccountId'] ?? '',
        isStripeOnboarded: json['isStripeOnboarded'] ?? false,
        passwordResetToken: json['password_reset_token'] ?? '',
        fine: json['fine'] ?? 0,
        refreshToken: json['refreshToken'] ?? '',
        uniqueId: json['uniqueId'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );

  @override
  List<Object?> get props => [id, email, username];
}

class Avatar extends Equatable {
  final String publicId;
  final String url;
  const Avatar({required this.publicId, required this.url});
  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(publicId: json['public_id'] ?? '', url: json['url'] ?? '');
  @override
  List<Object?> get props => [publicId, url];
}

class VerificationInfo extends Equatable {
  final bool verified;
  final String token;
  const VerificationInfo({required this.verified, required this.token});
  factory VerificationInfo.fromJson(Map<String, dynamic> json) =>
      VerificationInfo(
        verified: json['verified'] ?? false,
        token: json['token'] ?? '',
      );
  @override
  List<Object?> get props => [verified, token];
}

class UserRating extends Equatable {
  final RatingCategory competence;
  final RatingCategory punctuality;
  final RatingCategory behavior;
  const UserRating({
    required this.competence,
    required this.punctuality,
    required this.behavior,
  });
  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
    competence: RatingCategory.fromJson(json['competence'] ?? const {}),
    punctuality: RatingCategory.fromJson(json['punctuality'] ?? const {}),
    behavior: RatingCategory.fromJson(json['behavior'] ?? const {}),
  );
  @override
  List<Object?> get props => [competence, punctuality, behavior];
}

class RatingCategory extends Equatable {
  final int star;
  final String comment;
  const RatingCategory({required this.star, required this.comment});
  factory RatingCategory.fromJson(Map<String, dynamic> json) =>
      RatingCategory(star: json['star'] ?? 0, comment: json['comment'] ?? '');
  @override
  List<Object?> get props => [star, comment];
}

class TradingProfile extends Equatable {
  final String tradingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> preferredLearning;
  const TradingProfile({
    required this.tradingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.preferredLearning,
  });
  factory TradingProfile.fromJson(Map<String, dynamic> json) => TradingProfile(
    tradingExperience:
        json['trading_exprience'] ?? json['trading_experience'] ?? '',
    assetsOfInterest: json['assets_of_interest'] ?? '',
    mainGoal: json['main_goal'] ?? '',
    riskAppetite: json['risk_appetite'] ?? '',
    preferredLearning: (json['preffered_learning'] as List? ?? [])
        .map((e) => e.toString())
        .toList(),
  );
  @override
  List<Object?> get props => [tradingExperience, assetsOfInterest, mainGoal];
}

class Module extends Equatable {
  final String id;
  final String name;
  final List<dynamic> video;
  final List<dynamic> resources;
  final List<Assignment> assignments;
  const Module({
    required this.id,
    required this.name,
    required this.video,
    required this.resources,
    required this.assignments,
  });
  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    video: (json['video'] as List? ?? []),
    resources: (json['resources'] as List? ?? []),
    assignments: (json['assignment'] as List? ?? [])
        .map((e) => Assignment.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  @override
  List<Object?> get props => [id, name];
}

class Assignment extends Equatable {
  final String title;
  final String start;
  final List<dynamic> submission;
  final String id;
  const Assignment({
    required this.title,
    required this.start,
    required this.submission,
    required this.id,
  });
  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    title: json['title'] ?? '',
    start: json['start'] ?? '',
    submission: (json['submission'] as List? ?? []),
    id: json['_id'] ?? '',
  );
  @override
  List<Object?> get props => [id, title];
}
