import 'package:get/get.dart';
import '../../controllers/module_details_controller.dart';

class ModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModulesDetailsController());
  }
}