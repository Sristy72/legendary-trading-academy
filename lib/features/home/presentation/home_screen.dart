import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course/models/course_details.dart';
import 'package:flutter_ladydenily/features/course/presentation/course_all_screen.dart';
import '../widgets/course_card.dart';
import '../widgets/trainer_card.dart';
import '../widgets/market_card.dart';
import '../../../dummy_data.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

void _navigateToCoursesDetails(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CourseAllScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Hello, User Name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () {
              // Calendar function here
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Notification function here
            },
          ),
          const SizedBox(width: 16),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Courses', onViewAllTap: () => _navigateToCoursesDetails(context)),
            _buildHorizontalList(dummyCourses.map((c) => CourseCard(course:c)).toList()),

            _buildSectionTitle('Top Trainer'),
            _buildVerticalList(dummyTrainers.map((t) => TrainerCard(trainer: t)).toList()),

            _buildSectionTitle('Marketplace'),
            _buildHorizontalList(dummyMarketplace.map((m) => MarketCard(item: m)).toList()),

            _buildSectionTitle('My Courses'),
            _buildHorizontalList(dummyMyCourses.map((c) => CourseCard(course: c)).toList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAllTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: onViewAllTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "View All", 
                style: TextStyle(
                  color: Colors.blue[700], 
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<Widget> cards) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => cards[index],
      ),
    );
  }
  
  Widget _buildVerticalList(List<Widget> cards) {
  return Column(
    children: cards
        .map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: card,
            ))
        .toList(),
  );
}

}
