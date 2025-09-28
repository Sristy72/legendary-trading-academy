import 'package:flutter_ladydenily/core/network/network_result.dart';
import 'package:flutter_ladydenily/features/course_content/data/modules/course_response_module.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../domain/course_repo.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;

  CourseRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<List<CourseResponse>> getAllCourses() {
    return _apiClient.get<List<CourseResponse>>(
      ApiConstants.course.getAllCourses,
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }

  @override
  NetworkResult<CourseResponse> getCourseDetails(String courseId) {
    return _apiClient.get<CourseResponse>(
      '${ApiConstants.course.getCourseDetails}/$courseId',
      fromJsonT: (json) => CourseResponse.fromJson(json),
    );
  }

  @override
  NetworkResult<List<CourseResponse>> getCourseModules(String moduleId) {
    return _apiClient.get<List<CourseResponse>>(
      '${ApiConstants.course.getCourseModules}/$moduleId',
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }
}
