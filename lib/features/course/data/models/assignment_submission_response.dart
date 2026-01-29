class AssignmentSubmissionResponse {
  final String title;
  final String start;
  final List<Submission> submission;
  final String id;

  AssignmentSubmissionResponse({
    required this.title,
    required this.start,
    required this.submission,
    required this.id,
  });

  factory AssignmentSubmissionResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmissionResponse(
      title: json['title'] as String,
      start: json['start'] as String,
      submission: (json['submission'] as List<dynamic>)
          .map((e) => Submission.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start': start,
      'submission': submission.map((e) => e.toJson()).toList(),
      '_id': id,
    };
  }
}

class Submission {
  final String userId;
  final String? url;
  final String submittedAt;
  final String id;

  Submission({
    required this.userId,
    this.url,
    required this.submittedAt,
    required this.id,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      userId: json['userId'] as String,
      url: json['url'] as String?,
      submittedAt: json['submittedAt'] as String,
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'url': url,
      'submittedAt': submittedAt,
      '_id': id,
    };
  }
}
