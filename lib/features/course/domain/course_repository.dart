import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import '../models/course.dart';

// added imports for course_content APIs
import 'package:flutter_ladydenily/core/network/network_result.dart';
import '../../course_content/data/modules/course_response_module.dart';

abstract class CourseRepository {
  // existing course feature API
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses();

  // course_content related APIs (returns NetworkResult wrappers)
  NetworkResult<List<CourseResponse>> getAllCourses();
  NetworkResult<CourseResponse> getCourseDetails(String courseId);
  NetworkResult<List<CourseResponse>> getCourseModules(String moduleId);
}
