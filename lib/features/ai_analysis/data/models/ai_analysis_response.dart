class AiAnalysisResponse {
  final String analysis;

  AiAnalysisResponse({required this.analysis});

  factory AiAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AiAnalysisResponse(analysis: json['analysis'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'analysis': analysis};
  }
}
