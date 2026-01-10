import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/community/presentation/controllers/community_controller.dart';
import 'package:flutter_ladydenily/features/community/presentation/widgets/community_list_item.dart';
import 'package:flutter_ladydenily/features/community/presentation/screens/chat_details_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/main.dart'; // Import for routeObserver
import 'package:get/get.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with RouteAware {
  late CommunityController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CommunityController>();
    // Assume we start visible
    controller.startPolling();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    controller.stopPolling();
    super.dispose();
  }

  @override
  void didPushNext() {
    // Covered by another route
    controller.stopPolling();
  }

  @override
  void didPopNext() {
    // Returned to top
    controller.startPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.searchBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: controller.searchCommunity,
                  decoration: InputDecoration(
                    hintText: 'Search Community',
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  );
                }

                if (controller.filteredCommunityList.isEmpty) {
                  return Center(
                    child: Text(
                      'No communities found',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.filteredCommunityList.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey[300], indent: 76),
                  itemBuilder: (context, index) {
                    final item = controller.filteredCommunityList[index];
                    return CommunityListItem(
                      item: item,
                      onTap: () {
                        try {
                          final profileController = Get.find<ProfileController>();
                          final currentUserId = profileController.userInfo.value?.id ?? '';
                          
                          if (currentUserId.isEmpty) {
                            Get.snackbar('Error', 'Please wait for profile to load');
                            profileController.fetchProfile();
                            return;
                          }

                          Get.to(() => ChatDetailsScreen(
                            communityItem: item,
                            currentUserId: currentUserId,
                          ));
                        } catch (e) {
                          Get.snackbar('Error', 'Could not open chat: ${e.toString()}');
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
