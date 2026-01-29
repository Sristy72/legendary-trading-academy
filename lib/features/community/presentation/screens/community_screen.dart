import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/community/presentation/controllers/community_controller.dart';
import 'package:flutter_ladydenily/features/community/presentation/screens/chat_details_screen.dart';
import 'package:flutter_ladydenily/features/community/presentation/widgets/community_list_item.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with WidgetsBindingObserver {
  late CommunityController controller;
  bool _isScreenActive = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CommunityController>();
    WidgetsBinding.instance.addObserver(this);
    // Mark as active when first created
    _isScreenActive = true;
    controller.startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isScreenActive = false;
    controller.stopPolling();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Stop polling when app goes to background
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      controller.stopPolling();
    } else if (state == AppLifecycleState.resumed) {
      // Only resume if screen is still mounted and active
      if (_isScreenActive && mounted) {
        controller.startPolling();
      }
    }
  }

  // Called when widget becomes visible in the widget tree
  @override
  void didUpdateWidget(CommunityScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted && _isScreenActive) {
      controller.startPolling();
    }
  }

  // Pause polling when navigating away
  @override
  void deactivate() {
    _isScreenActive = false;
    controller.stopPolling();
    super.deactivate();
  }

  // Resume polling when coming back
  @override
  void activate() {
    super.activate();
    _isScreenActive = true;
    if (mounted) {
      controller.startPolling();
    }
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
