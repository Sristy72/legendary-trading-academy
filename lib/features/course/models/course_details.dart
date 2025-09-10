class CourseDetails {
  final String title;
  final String subtitle;
  final String weeks;
  final String modules;
  final String price;
  final String image;
  final String status;
  final String level;
  final String trainerName;
  final String trainerImage;
  final String trainerStats;
  final List<String> benefitImages;
  final List<String> benefits;

  CourseDetails({
    required this.title,
    required this.subtitle,
    required this.weeks,
    required this.modules,
    required this.price,
    required this.image,
    required this.status,
    required this.level,
    required this.trainerName,
    required this.trainerImage,
    required this.trainerStats,
    required this.benefits,
    required this.benefitImages,
  });
}

    // trainerName : "Trainer 1",
    // trainerImage: "assets/images/trainer1.jpg",
    // trainerStats: "Expert",