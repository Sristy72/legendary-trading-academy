import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/course_all_screen.dart';
import 'package:flutter_ladydenily/features/home/models/course.dart';
import 'package:flutter_ladydenily/core/widgets/custom_bottom_navbar.dart';
import 'package:flutter_ladydenily/features/notification/presentation/screens/notification_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';
import '../../../calender/presentation/screens/calender_screen.dart';
import '../widgets/course_card.dart';
import '../widgets/trainer_card.dart';
import '../widgets/market_card.dart';
import '../../../../dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(), 
      const Center(child: Text("👥 Community Page")), 
      CourseAllScreen(), 
      ProfileScreen(), 
    ];
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTapped,
      ),
    );
  }
}

// ---------------- HomeContent (scrollable home body) ---------------- //
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _navigateToCoursesDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseAllScreen()),
    );
  }

  void _navigateToCourseDetail(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.to(ProfileScreen()),
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  "assets/images/profile.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hello, User Name',
                  style: TextStyle(
                    color: AppColors.titleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'New York, NY',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => Get.to(CalendarScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Get.to(NotificationScreen()),
          ),
          const SizedBox(width: 16),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),

            _buildSectionTitle(
              'Courses',
              onViewAllTap: () => _navigateToCoursesDetails(context),
            ),
            _buildHorizontalList(
              dummyCourses
                  .map((c) => _buildClickableCourseCard(c, context))
                  .toList(),
            ),

            _buildSectionTitle('Top Trainer'),
            _buildVerticalList(
              dummyTrainers.map((t) => TrainerCard(trainer: t)).toList(),
            ),

            _buildSectionTitle('Marketplace'),
            _buildHorizontalList(
              dummyMarketplace.map((m) => MarketCard(item: m)).toList(),
            ),

            _buildSectionTitle('My Courses'),
            _buildHorizontalList(
              dummyMyCourses
                  .map((c) => _buildClickableCourseCard(c, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableCourseCard(Course course, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToCourseDetail(context, course),
      child: CourseCard(course: course),
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAllTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textColorBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onViewAllTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "View All",
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.w500,
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
          .map(
            (card) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: card,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.searchBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 4),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search courses, trainers...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: AppColors.emailIconColor),
          suffixIcon: Icon(Icons.filter_list, color: AppColors.emailIconColor),
        ),
      ),
    );
  }
}
