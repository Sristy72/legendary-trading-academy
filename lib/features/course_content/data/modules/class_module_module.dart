import 'assignment_module.dart';

class Module {
  final String id;
  final String name;
  final List<dynamic> video;
  final List<dynamic> resources;
  final List<Assignment> assignment;

  Module({
    required this.id,
    required this.name,
    required this.video,
    required this.resources,
    required this.assignment,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json["_id"],
    name: json["name"],
    video: List<dynamic>.from(json["video"]),
    resources: List<dynamic>.from(json["resources"]),
    assignment: List<Assignment>.from(
      json["assignment"].map((x) => Assignment.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "video": List<dynamic>.from(video),
    "resources": List<dynamic>.from(resources),
    "assignment": List<dynamic>.from(assignment.map((x) => x.toJson())),
  };
}
