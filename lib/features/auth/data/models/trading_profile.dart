class TredingProfile {
  final String tredingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> preferredLearning;

  TredingProfile({
    required this.tredingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.preferredLearning,
  });

  factory TredingProfile.fromJson(Map<String, dynamic> json) {
    return TredingProfile(
      tredingExperience: json["treding_exprience"] ?? "",
      assetsOfInterest: json["assets_of_interest"] ?? "",
      mainGoal: json["main_goal"] ?? "",
      riskAppetite: json["risk_appetite"] ?? "",
      preferredLearning: List<String>.from(json["preffered_learning"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "treding_exprience": tredingExperience,
      "assets_of_interest": assetsOfInterest,
      "main_goal": mainGoal,
      "risk_appetite": riskAppetite,
      "preffered_learning": preferredLearning,
    };
  }
}