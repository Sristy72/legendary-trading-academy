import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/models/course.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/course_all_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/course_details_card.dart';
import 'package:flutter_ladydenily/core/widgets/custom_bottom_navbar.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/marketplace_all_screen.dart';
import 'package:flutter_ladydenily/features/notification/presentation/screens/notification_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/home/presentation/controllers/trainer_controller.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/trainer_api_card.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/trainer_placeholder_card.dart';
import 'package:get/get.dart';
import '../../../calender/presentation/screens/calender_screen.dart';
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _navigateToCoursesDetails(BuildContext context) {
    Get.to(() => CourseAllScreen());
  }

  void _navigateToCourseDetail(BuildContext context, Course course) {
    Get.to(() => CourseDetailsScreen(), arguments: course);
  }

  void _navgiateToAllMarketplace(BuildContext context) {
    Get.to(() => const MarketplaceAllScreen());
  }

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();
    final profileController = Get.find<ProfileController>();
    final trainerController = Get.find<TrainerController>();

    // Fetch profile if not already loaded
    if (profileController.userInfo.value == null) {
      profileController.fetchProfile();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              children: [
                Obx(() {
                  final user = profileController.userInfo.value;
                  final name = user?.name ?? user?.username ?? 'User';
                  return Text(
                    'Hello, $name',
                    style: const TextStyle(
                      color: AppColors.titleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                const Text(
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
            Obx(
              () => courseController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildHorizontalList(
                      courseController.courses
                          .map(
                            (c) => GestureDetector(
                              onTap: () => _navigateToCourseDetail(context, c),
                              child: SizedBox(
                                width: 300,
                                child: CourseDetailsCard(course: c),
                              ),
                            ),
                          )
                          .toList(),
                      height: 340,
                    ),
            ),

            _buildSectionTitle('Top Trainer'),
            Obx(() {
              if (trainerController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return _buildTopTrainersList(trainerController);
            }),

            _buildSectionTitle(
              'Marketplace',
              onViewAllTap: () => _navgiateToAllMarketplace(context),
            ),
            _buildHorizontalList(
              dummyMarketplace.map((m) => MarketCard(item: m)).toList(),
              height: 280,
            ),

            _buildSectionTitle('My Courses'),
            Obx(
              () => courseController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildVerticalList(
                      courseController.courses
                          .where((c) => c.enrolled.isNotEmpty)
                          .map(
                            (c) => GestureDetector(
                              onTap: () => _navigateToCourseDetail(context, c),
                              child: CourseDetailsCard(course: c),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTrainersList(TrainerController trainerController) {
    final trainers = trainerController.topTrainers.take(3).toList();
    final List<Widget> trainerWidgets = [];

    // Add actual trainers
    for (var trainer in trainers) {
      trainerWidgets.add(TrainerApiCard(trainer: trainer));
    }

    // Add placeholder cards to fill up to 3 total cards
    final remainingSlots = 3 - trainers.length;
    for (int i = 0; i < remainingSlots; i++) {
      trainerWidgets.add(const TrainerPlaceholderCard());
    }

    return _buildVerticalList(trainerWidgets);
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

  Widget _buildHorizontalList(List<Widget> cards, {double height = 200}) {
    return SizedBox(
      height: height,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search courses or trainers...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppColors.hintText),
            suffixIcon: Icon(Icons.filter_list, color: AppColors.hintText),
          ),
        ),
      ),
    );
  }
}
