import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import '../widgets/my_course_card.dart';

class MyCoursesAllScreen extends GetView<CourseController> {
  const MyCoursesAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CourseController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Courses',
          style: TextStyle(
            color: AppColors.titleTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.courses.isEmpty) {
          return const Center(child: Text('No courses found'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final course = controller.courses[index];
            return MyCourseCard(course: course);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: controller.courses.length,
        );
      }),
    );
  }
}
