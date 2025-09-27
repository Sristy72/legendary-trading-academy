import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/controllers/module_controller.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/controllers/module_details_controller.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controller/auth_controller.dart';

void setupController() {
  // Auth Controller
  Get.lazyPut<AuthController>(() => AuthController(Get.find(), Get.find()));
  Get.lazyPut<ProfileController>(() => ProfileController(Get.find()));

  // Course Content Controllers
  Get.lazyPut<ModuleController>(() => ModuleController(Get.find()));
  Get.lazyPut<ModulesDetailsController>(
    () => ModulesDetailsController(Get.find()),
  );

  
}
