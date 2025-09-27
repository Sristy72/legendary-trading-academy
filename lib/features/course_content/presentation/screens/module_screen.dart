import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_details_screen.dart';
import 'package:flutter_ladydenily/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:get/get.dart';
import '../widgets/items_widgets.dart';
import '../controllers/module_controller.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModuleController controller = Get.find<ModuleController>();

    // Try to load the course when this screen is built (id provided by previous page)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = Get.arguments;
      if (arg != null &&
          arg is String &&
          (controller.rxSelectedCourse.value == null ||
              controller.rxSelectedCourse.value!.id != arg)) {
        controller.loadCourseById(arg);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = controller.rxSelectedCourse.value?.name ?? 'Course';
          return Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff1A3E74),
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: [
                    ItemWidget(
                      index: 0,
                      title: 'Modules',
                      ImagePath: "assets/images/periodic-table_2183917.png",
                      isSelected: controller.selectedIndex == 0,
                      trailingText: controller.rxSelectedCourse.value == null
                          ? null
                          : '${controller.rxSelectedCourse.value!.modules.length} items',
                      onTap: () {
                        controller.selectItem(0);
                        final courseId =
                            controller.rxSelectedCourse.value?.id ??
                            '68bd11bb31fb45d7d231ff17';
                        Get.to(
                          () => const ModulesDetailsScreen(),
                          arguments: courseId,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 1,
                      title: 'Recordings',
                      ImagePath: "assets/images/folder_12533516.png",
                      isSelected: controller.selectedIndex == 1,
                      trailingText: controller.rxSelectedCourse.value == null
                          ? null
                          : '${controller.rxSelectedCourse.value!.modules.fold<int>(0, (p, m) => p + m.video.length)}',
                      onTap: () => controller.selectItem(1),
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 2,
                      title: 'Resources',
                      ImagePath: "assets/images/folder_15237642.png",
                      isSelected: controller.selectedIndex == 2,
                      trailingText: controller.rxSelectedCourse.value == null
                          ? null
                          : '${controller.rxSelectedCourse.value!.modules.fold<int>(0, (p, m) => p + m.resources.length)}',
                      onTap: () => controller.selectItem(2),
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 3,
                      title: 'Community',
                      ImagePath: "assets/images/community_12575799.png",
                      isSelected: controller.selectedIndex == 3,
                      onTap: () => controller.selectItem(3),
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 4,
                      title: 'Assignment',
                      ImagePath: "assets/images/appraisal_15210198.png",
                      isSelected: controller.selectedIndex == 4,
                      trailingText: controller.rxSelectedCourse.value == null
                          ? null
                          : '${controller.rxSelectedCourse.value!.modules.fold<int>(0, (p, m) => p + m.assignment.length)}',
                      onTap: () => controller.selectItem(4),
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 5,
                      title: 'Quiz',
                      ImagePath: "assets/images/quiz_8586995.png",
                      isSelected: controller.selectedIndex == 5,
                      onTap: () {
                        controller.selectItem(5);
                        Get.to(() => QuizScreen());
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 6,
                      title: 'Certificate',
                      ImagePath: "assets/images/legal-document_1890467.png",
                      isSelected: controller.selectedIndex == 6,
                      onTap: () => controller.selectItem(6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
