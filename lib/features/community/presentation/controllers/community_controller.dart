import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';
import 'package:get/get.dart';
import 'dart:async';

class CommunityController extends GetxController {
  final CommunityRepository repository;

  CommunityController({required this.repository});

  final communityList = <CommunityItem>[].obs;
  final filteredCommunityList = <CommunityItem>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchCommunityList();
    startPolling();
  }

  @override
  void onClose() {
    stopPolling();
    super.onClose();
  }

  void startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (searchQuery.isEmpty) { // Only poll if not searching, or user preference
        fetchCommunityList(isSilent: true);
      }
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetchCommunityList({bool isSilent = false}) async {
    try {
      if (!isSilent) isLoading.value = true;
      // print('[CommunityController] calling repository.fetchCommunityList()'); // Reduced log noise
      final result = await repository.fetchCommunityList();

      result.fold(
        (failure) {
          if (!isSilent) print('[CommunityController] failure: ${failure.message}');
          // On silent failure, we might keep old data to avoid flicker/empty screen
          if (!isSilent) {
             communityList.clear();
             filteredCommunityList.clear();
          }
        },
        (success) {
          // Only update if data changed? Obx handles equality check often, but lists are mutable.
          // For now, assigning all is fine.
          
          communityList.assignAll(success.data);
          
          if (searchQuery.value.isEmpty) {
            filteredCommunityList.assignAll(success.data);
          } else {
            // If searching, re-filter the new list
            searchCommunity(searchQuery.value);
          }
        },
      );
    } catch (e) {
      print('Error fetching community list: $e');
      if (!isSilent) {
        communityList.clear();
        filteredCommunityList.clear();
      }
    } finally {
      if (!isSilent) isLoading.value = false;
    }
  }

  void searchCommunity(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCommunityList.assignAll(communityList);
    } else {
      filteredCommunityList.assignAll(
        communityList
            .where(
              (item) =>
                  item.displayName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
