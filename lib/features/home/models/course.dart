// Renamed to HomeCourse to avoid conflict with API Course model
class HomeCourse {
  final String title;
  final String price;
  final int lessons;
  final String level;
  final String image;

  HomeCourse({
    required this.title,
    required this.price,
    required this.lessons,
    required this.level,
    required this.image,
  });
}
