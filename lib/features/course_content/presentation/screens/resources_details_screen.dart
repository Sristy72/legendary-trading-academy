import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/app_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/resource_details_controller.dart';
import '../widgets/module_all_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResourcesController controller = Get.put(
      ResourcesController(repository: Get.find()),
    );

    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Resources",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.modules.isEmpty) {
          return const Center(child: Text('No resources found'));
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            final module = controller.modules[index];
            return ModuleAllResources(
              module: module,
              index: index,
            ); // Pass the index here
          },
          itemCount: controller.modules.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
        );
      }),
    );
  }
}
