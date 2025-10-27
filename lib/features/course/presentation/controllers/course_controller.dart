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
      print('[CourseController] calling repository.fetchAllCourses()');
      final result = await repository.fetchAllCourses();
      print(
        '[CourseController] repository returned type: ${result.runtimeType}',
      );

      // Either<NetworkFailure, NetworkSuccess<List<Course>>> expected
      result.fold(
        (failure) {
          print('[CourseController] fetch failed: ${failure.message}');
          courses.clear();
        },
        (success) {
          final payload = success.data; // NetworkSuccess.data is non-nullable
          courses.assignAll(payload);
          print('>>>>>>> API COURSES loaded: ${courses.length}');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
