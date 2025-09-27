class Assignment {
  final String id;
  final String title;
  final String start;
  final List<dynamic> submission;

  Assignment({
    required this.id,
    required this.title,
    required this.start,
    required this.submission,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["_id"],
    title: json["title"],
    start: json["start"],
    submission: List<dynamic>.from(json["submission"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "start": start,
    "submission": List<dynamic>.from(submission),
  };
}
