import 'features/home/models/course.dart';
import 'features/home/models/trainer.dart';
import 'features/home/models/market_item.dart';

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
// lib/features/courses/data/dummy_course.dart
