class Video {
  final String? name;
  final int? no;
  final String? url;

  Video({this.name, this.no, this.url});

  factory Video.fromJson(Map<String, dynamic> json) =>
      Video(name: json["name"], no: json["no"] ?? 1, url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "no": no, "url": url};
}
