class Avatar {
  final String publicId;
  final String url;

  Avatar({required this.publicId, required this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(publicId: json["public_id"], url: json["url"]);

  Map<String, dynamic> toJson() => {"public_id": publicId, "url": url};
}
