
class EventModel {
  final String? id;
  final String? userId;
  final Course? course;
  final String? title;
  final String? description;
  final String? date;
  final String? createdAt;
  final String? updatedAt;

  EventModel({
    this.id,
    this.userId,
    this.course,
    this.title,
    this.description,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] as String?,
      userId: json['user'] as String?,
      course: json['course'] != null
          ? Course.fromJson(json['course'] as Map<String, dynamic>)
          : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class Course {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final double? offerPrice;
  final String? photo;
  final List<Coordinator>? coordinator;

  Course({
    this.id,
    this.name,
    this.description,
    this.price,
    this.offerPrice,
    this.photo,
    this.coordinator,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offerPrice'] as num?)?.toDouble(),
      photo: json['photo'] as String?,
      coordinator: (json['coordinator'] as List?)
          ?.map((e) => Coordinator.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Coordinator {
  final String? id;
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? role;
  final Avatar? avatar;

  Coordinator({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.role,
    this.avatar,
  });

  factory Coordinator.fromJson(Map<String, dynamic> json) {
    return Coordinator(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] != null
          ? Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
          : null,
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
}
