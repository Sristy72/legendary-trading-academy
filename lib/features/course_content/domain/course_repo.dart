import 'package:flutter_ladydenily/core/network/network_result.dart';
import '../data/modules/course_response_module.dart';

abstract class CourseRepository {
  NetworkResult<List<CourseResponse>> getAllCourses();
  NetworkResult<CourseResponse> getCourseDetails(String courseId);
  // NetworkResult<List<CourseResponse>> getCourseModules(String courseId);
}
