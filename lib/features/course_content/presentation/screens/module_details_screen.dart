import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/module_details_controller.dart';
import '../widgets/module_details_card_widget.dart';

class ModulesDetailsScreen extends StatelessWidget {
  const ModulesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModulesDetailsController controller = Get.put(ModulesDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modules',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1A3E74),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.modules.length,
              itemBuilder: (context, index) {
                final module = controller.modules[index];
                return buildModuleCard(module, index, controller);
              },
            )),
          ),
        ],
      ),
    );
  }
}