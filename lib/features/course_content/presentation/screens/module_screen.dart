import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_details_screen.dart';
import 'package:get/get.dart';
import '../state/module_state.dart';
import '../widgets/items_widgets.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModuleController controller = Get.put(ModuleController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35,),
              Row(
                children: [
                  const SizedBox(height: 18),
                  const Icon(Icons.arrow_back_ios, color: Colors.black,),
                  const SizedBox( width: 16,),
                  const Text(
                    'Technical Analysis Mastery',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              ],),
              const SizedBox(height: 24),
              Obx(() => Column(
                children: [
                  ItemWidget(
                    index: 0,
                    title: 'Modules',
                    ImagePath: "assets/images/periodic-table_2183917.png",
                    isSelected: controller.selectedIndex.value == 0,
                    onTap: (){
                      controller.selectItem(0);
                      Get.to(() => const ModulesDetailsScreen());
                    },
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 1,
                    title: 'Recordings',
                    ImagePath: "assets/images/folder_12533516.png",
                    isSelected: controller.selectedIndex.value == 1,
                    onTap: () => controller.selectItem(1),
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 2,
                    title: 'Resources',
                    ImagePath: "assets/images/folder_15237642.png",
                    isSelected: controller.selectedIndex.value == 2,
                    onTap: () => controller.selectItem(2),
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 3,
                    title: 'Community',
                    ImagePath: "assets/images/community_12575799.png",
                    isSelected: controller.selectedIndex.value == 3,
                    onTap: () => controller.selectItem(3),
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 4,
                    title: 'Assignment',
                    ImagePath: "assets/images/appraisal_15210198.png",
                    isSelected: controller.selectedIndex.value == 4,
                    onTap: () => controller.selectItem(4),
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 5,
                    title: 'Quiz',
                    ImagePath: "assets/images/quiz_8586995.png",
                    isSelected: controller.selectedIndex.value == 5,
                    onTap: () => controller.selectItem(5),
                  ),
                  const SizedBox(height: 12,),
                  ItemWidget(
                    index: 6,
                    title: 'Certificate',
                    ImagePath: "assets/images/legal-document_1890467.png",
                    isSelected: controller.selectedIndex.value == 6,
                    onTap: () => controller.selectItem(6),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}