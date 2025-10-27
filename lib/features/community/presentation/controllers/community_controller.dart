import 'package:get/get.dart';
import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';

class CommunityController extends GetxController {
  final CommunityRepository repository;

  CommunityController({required this.repository});

  final communityList = <CommunityItem>[].obs;
  final filteredCommunityList = <CommunityItem>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommunityList();
  }

  Future<void> fetchCommunityList() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchCommunityList();
      communityList.assignAll(result);
      filteredCommunityList.assignAll(result);
    } catch (e) {
      print('Error fetching community list: $e');
    } finally {
      isLoading.value = false;
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
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
