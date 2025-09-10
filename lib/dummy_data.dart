import 'features/home/models/course.dart';
import 'features/home/models/trainer.dart';
import 'features/home/models/market_item.dart';
import 'package:flutter_ladydenily/features/course/models/course_details.dart';

final List<MarketItem> dummyMarketItems = [
  MarketItem(
    title: "Legendary Book",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    price: "\$99.99",
    image: "assets/images/book1.jpg", // ekhane local asset use koro
    tag: "Free",
  ),
  MarketItem(
    title: "Legendary Software",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    price: "\$99.99",
    image: "assets/images/toolkit.jpg",
    tag: "New",
  ),
];

final List<Trainer> dummyTrainers = [
  Trainer(name: 'Trainer 1', courses: 3, image: 'assets/images/trainer1.png'),
  Trainer(name: 'Trainer 2', courses: 5, image: 'assets/images/trainer2.png'),
  Trainer(name: 'Trainer 3', courses: 2, image: 'assets/images/trainer3.png'),
];

final List<MarketItem> dummyMarketplace = [
  MarketItem(
    title: 'Legendary Book',
    price: '\$99.99',
    image: 'assets/images/book1.jpg',
    description: 'Lorem ipsum dolor sit ametLorem ipsum dolor sit amet',
    tag: 'Tag1',
  ),
  MarketItem(
    title: 'Forex Toolkit',
    price: '\$49.99',
    image: 'assets/images/toolkit.jpg',
    description: 'Lorem ipsum dolor sit ametLorem ipsum dolor sit amet',
    tag: 'Tag2',
  ),
];

final List<Course> dummyMyCourses = [
  Course(
    title: 'Forex Fundamentals',
    price: '\$99.99',
    lessons: 12,
    level: 'Sophomore',
    image: 'assets/images/mycourses1.jpg',
  ),
  Course(
    title: 'Risk Management',
    price: '\$79.99',
    lessons: 10,
    level: 'Intermediate',
    image: 'assets/images/mycourses2.jpg',
  ),
];

final List<Course> dummyCourses = [
  Course(
    title: 'Technical Analysis Mastery',
    price: '\$99.99',
    lessons: 12,
    level: 'Freshman',
    image: 'assets/images/courses_sample.jpg',
  ),
  Course(
    title: 'Stock Market Basics',
    price: '\$59.99',
    lessons: 8,
    level: 'Beginner',
    image: 'assets/images/courses_sample.jpg',
  ),
  Course(
    title: 'Crypto Trading',
    price: '\$149.99',
    lessons: 15,
    level: 'Intermediate',
    image: 'assets/images/courses_sample.jpg',
  ),
];

List<CourseDetails> dummyCoursesDetails = [
  CourseDetails(
    title: "Technical Analysis Mastery",
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    weeks: "4 Weeks",
    modules: "12 Modules",
    price: "\$99.99",
    image: "assets/images/courses_sample.jpg",
    status: "Enroll Now",
    level: 'Freshman',
    trainerName: "Trainer 1",
    trainerImage: "assets/images/trainer1.png",
    trainerStats: "Expert",
    benefitImages: [
      'assets/images/appraisal_15210198.png',
      'assets/images/community_12575799.png',
      'assets/images/folder_12533516.png',
      'assets/images/folder_15237642.png',
      'assets/images/legal-document_1890467.png',
    ],
    benefits: [
      '6-month guided journey',
      'Community Support',
      '12 Modules',
      'Numerous Resources',
      'Certificate',
    ],
  ),
  CourseDetails(
    title: "Technical Analysis Mastery",
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    weeks: "4 Weeks",
    modules: "12 Modules",
    price: "",
    image: "assets/images/courses_sample.jpg",
    status: "Continue Learning",
    level: 'Beginner',
    trainerName: "Trainer 1",
    trainerImage: "assets/images/trainer1.png",
    trainerStats: "Expert",
    benefitImages: [
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
    ],
    benefits: [
      '6-month guided journey',
      'Community Support',
      '12 Modules',
      'Numerous Resources',
      'Certificate',
    ],
  ),
  CourseDetails(
    title: "Technical Analysis Mastery",
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    weeks: "4 Weeks",
    modules: "12 Modules",
    price: "\$99.99",
    image: "assets/images/courses_sample.jpg",
    status: "Enroll Now",
    level: 'Intermediate',
    trainerName: "Trainer 1",
    trainerImage: "assets/images/trainer1.     ",
    trainerStats: "Expert",
    benefitImages: [
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
      'assets/images/book1.jpg',
    ],
    benefits: [
      '6-month guided journey',
      'Community Support',
      '12 Modules',
      'Numerous Resources',
      'Certificate',
    ],
  ),
];

// lib/features/courses/data/dummy_course.dart
