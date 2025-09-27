class Resource {
  final String? name;
  final String? url;

  Resource({this.name, this.url});

  factory Resource.fromJson(Map<String, dynamic> json) =>
      Resource(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
