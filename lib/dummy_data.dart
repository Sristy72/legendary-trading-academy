import 'features/home/models/course.dart';
import 'features/home/models/trainer.dart';
import 'features/home/models/market_item.dart';
import 'package:flutter_ladydenily/features/course/models/course_details.dart';



final List<Trainer> dummyTrainers = [
  Trainer(name: 'Trainer 1', courses: 3, image: 'assets/images/trainer1.jpg'),
  Trainer(name: 'Trainer 2', courses: 5, image: 'assets/images/trainer2.jpg'),
  Trainer(name: 'Trainer 3', courses: 2, image: 'assets/images/trainer3.jpg'),
];

final List<MarketItem> dummyMarketplace = [
  MarketItem(title: 'Legendary Book', price: '\$99.99', image: 'assets/images/book1.jpg'),
  MarketItem(title: 'Forex Toolkit', price: '\$49.99', image: 'assets/images/toolkit.jpg'),
];

final List<Course> dummyMyCourses = [
  Course(title: 'Forex Fundamentals', price: '\$99.99', lessons: 12, level: 'Sophomore', image: 'assets/images/mycourses1.jpg'),
  Course(title: 'Risk Management', price: '\$79.99', lessons: 10, level: 'Intermediate', image: 'assets/images/mycourses2.jpg'),
];

final List<Course> dummyCourses = [
  Course(title: 'Technical Analysis Mastery', price: '\$99.99', lessons: 12, level: 'Freshman', image: 'assets/images/courses_sample.jpg',),
  Course(title: 'Stock Market Basics', price: '\$59.99', lessons: 8, level: 'Beginner', image: 'assets/images/courses_sample.jpg',),
  Course(title: 'Crypto Trading', price: '\$149.99', lessons: 15, level: 'Intermediate', image: 'assets/images/courses_sample.jpg',),
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
  ),
  CourseDetails(
    title: "Technical Analysis Mastery",
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    weeks: "4 Weeks",
    modules: "12 Modules",
    price: "",
    image:"assets/images/courses_sample.jpg",
    status: "Continue Learning",
    level: 'Beginner',
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
  ),
];