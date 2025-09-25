class AuthResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? role;
  final String? id;
  final User? user;

  AuthResponseModel({
    this.accessToken,
    this.refreshToken,
    this.role,
    this.id,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      role: json['role'] as String?,
      id: json['_id'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final Avatar? avatar;
  final VerificationInfo? verificationInfo;
  final UserRating? userRating;
  final TradingProfile? tradingProfile;
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? username;
  final String? phone;
  final dynamic credit;
  final String? role;
  final String? stripeAccountId;
  final bool? isStripeOnboarded;
  final String? passwordResetToken;
  final int? fine;
  final String? refreshToken;
  final String? uniqueId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? tradingProfileComplete;
  final String? address;
  final String? age; // kept String since API sends "26"
  final String? gender;
  final String? nationality;

  User({
    this.avatar,
    this.verificationInfo,
    this.userRating,
    this.tradingProfile,
    this.id,
    this.name,
    this.email,
    this.password,
    this.username,
    this.phone,
    this.credit,
    this.role,
    this.stripeAccountId,
    this.isStripeOnboarded,
    this.passwordResetToken,
    this.fine,
    this.refreshToken,
    this.uniqueId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.tradingProfileComplete,
    this.address,
    this.age,
    this.gender,
    this.nationality,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      verificationInfo: json['verificationInfo'] != null
          ? VerificationInfo.fromJson(json['verificationInfo'])
          : null,
      userRating: json['userRating'] != null
          ? UserRating.fromJson(json['userRating'])
          : null,
      tradingProfile: json['treding_profile'] != null
          ? TradingProfile.fromJson(json['treding_profile'])
          : null,
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      credit: json['credit'],
      role: json['role'] as String?,
      stripeAccountId: json['stripeAccountId'] as String?,
      isStripeOnboarded: json['isStripeOnboarded'] as bool?,
      passwordResetToken: json['password_reset_token'] as String?,
      fine: json['fine'] as int?,
      refreshToken: json['refreshToken'] as String?,
      uniqueId: json['uniqueId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      tradingProfileComplete: json['treding_profile_Complete'] as bool?,
      address: json['address'] as String?,
      age: json['age'] as String?, // still String
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
    );
  }
}

class Avatar {
  final String? publicId;
  final String? url;

  Avatar({this.publicId, this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "public_id": publicId,
      "url": url,
    };
  }
}

class VerificationInfo {
  final bool? verified;
  final String? token;

  VerificationInfo({this.verified, this.token});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    return VerificationInfo(
      verified: json['verified'] as bool?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "verified": verified,
      "token": token,
    };
  }
}

class UserRating {
  final Rating? competence;
  final Rating? punctuality;
  final Rating? behavior;

  UserRating({this.competence, this.punctuality, this.behavior});

  factory UserRating.fromJson(Map<String, dynamic> json) {
    return UserRating(
      competence: json['competence'] != null
          ? Rating.fromJson(json['competence'])
          : null,
      punctuality: json['punctuality'] != null
          ? Rating.fromJson(json['punctuality'])
          : null,
      behavior: json['behavior'] != null
          ? Rating.fromJson(json['behavior'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "competence": competence?.toJson(),
      "punctuality": punctuality?.toJson(),
      "behavior": behavior?.toJson(),
    };
  }
}

class Rating {
  final int? star;
  final String? comment;

  Rating({this.star, this.comment});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      star: json['star'] as int?,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "star": star,
      "comment": comment,
    };
  }
}

class TradingProfile {
  final String? tradingExperience;
  final String? assetsOfInterest;
  final String? mainGoal;
  final String? riskAppetite;
  final List<String>? preferredLearning;

  TradingProfile({
    this.tradingExperience,
    this.assetsOfInterest,
    this.mainGoal,
    this.riskAppetite,
    this.preferredLearning,
  });

  factory TradingProfile.fromJson(Map<String, dynamic> json) {
    return TradingProfile(
      tradingExperience: json['trading_exprience'] as String?,
      assetsOfInterest: json['assets_of_interest'] as String?,
      mainGoal: json['main_goal'] as String?,
      riskAppetite: json['risk_appetite'] as String?,
      preferredLearning: json['preffered_learning'] != null
          ? List<String>.from(json['preffered_learning'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trading_exprience": tradingExperience,
      "assets_of_interest": assetsOfInterest,
      "main_goal": mainGoal,
      "risk_appetite": riskAppetite,
      "preffered_learning": preferredLearning,
    };
  }
}
