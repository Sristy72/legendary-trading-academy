import 'package:get/get.dart';
import '../../domain/marketplace_repository.dart';
import '../../models/marketplace_item_api_model.dart';

class MarketplaceController extends GetxController {
  final MarketplaceRepository repository;
  MarketplaceController({required this.repository});

  final marketplaceItems = <MarketplaceItemApiModel>[].obs;
  final isLoading = false.obs;
  final selectedItem = Rxn<MarketplaceItemApiModel>();
  final isLoadingDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMarketplaceItems();
  }

  Future<void> fetchMarketplaceItems() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchAllMarketplaceItems();

      result.fold(
        (failure) {
          print('[MarketplaceController] failure: ${failure.message}');
          marketplaceItems.clear();
        },
        (success) {
          print(
            '[MarketplaceController] success.data length: ${success.data.length}',
          );
          if (success.data.isNotEmpty) {
            print(
              '[MarketplaceController] first item: ${success.data.first.title}',
            );
          }
          marketplaceItems.assignAll(success.data);
          print(
            '>>>>>>> API MARKETPLACE ITEMS loaded: ${marketplaceItems.length}',
          );
        },
      );
    } catch (e, st) {
      print('[MarketplaceController] fetchMarketplaceItems exception: $e\n$st');
      marketplaceItems.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMarketplaceItemById(String id) async {
    try {
      isLoadingDetails.value = true;
      selectedItem.value = null;
      print(
        '[MarketplaceController] calling repository.fetchMarketplaceItemById($id)',
      );
      final result = await repository.fetchMarketplaceItemById(id);
      print(
        '[MarketplaceController] repository returned type for details: ${result.runtimeType}',
      );

      result.fold(
        (failure) {
          print('[MarketplaceController] details failure: ${failure.message}');
          selectedItem.value = null;
        },
        (success) {
          print(
            '[MarketplaceController] details success: ${success.data.title}',
          );
          selectedItem.value = success.data;
          print(
            '>>>>>>> API MARKETPLACE ITEM DETAILS loaded: ${selectedItem.value?.title}',
          );
        },
      );
    } catch (e, st) {
      print(
        '[MarketplaceController] fetchMarketplaceItemById exception: $e\n$st',
      );
      selectedItem.value = null;
    } finally {
      isLoadingDetails.value = false;
    }
  }

  // Helper method to refresh marketplace items
  Future<void> refreshMarketplaceItems() async {
    await fetchMarketplaceItems();
  }
}
