import 'class_module_module.dart';
import 'coordinator_model.dart';

class CourseResponse {
  final String id;
  final String name;
  final String description;
  final String? photo;
  final int price;
  final int offerPrice;
  final List<Coordinator> coordinator;
  final List<Module> modules;
  final List<dynamic> enrolled;

  CourseResponse({
    required this.id,
    required this.name,
    required this.description,
    this.photo,
    required this.price,
    required this.offerPrice,
    required this.coordinator,
    required this.modules,
    required this.enrolled,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    photo: json["photo"],
    price: json["price"],
    offerPrice: json["offerPrice"],
    coordinator: List<Coordinator>.from(
      json["coordinator"].map((x) => Coordinator.fromJson(x)),
    ),
    modules: List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
    enrolled: List<dynamic>.from(json["enrolled"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "photo": photo,
    "price": price,
    "offerPrice": offerPrice,
    "coordinator": List<dynamic>.from(coordinator.map((x) => x.toJson())),
    "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
    "enrolled": List<dynamic>.from(enrolled),
  };
}
