import 'package:get/get.dart';

class ModuleController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}