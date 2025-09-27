import 'package:get/get.dart';
import '../../domain/course_repository.dart';
import '../../models/course.dart';

class CourseController extends GetxController {
  final CourseRepository repository;
  CourseController({required this.repository});

  final courses = <Course>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchAllCourses();
      result.fold(
        (failure) {
          courses.clear();
        },
        (success) {
          courses.assignAll(success.data);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
