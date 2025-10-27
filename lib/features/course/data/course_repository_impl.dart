import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';

import '../../../core/network/constants/api_constants.dart';
import '../../../core/network/models/network_failure.dart';
import '../../../core/network/models/network_success.dart';
import '../domain/course_repository.dart';
import '../models/course.dart';
import 'package:flutter_ladydenily/core/network/network_result.dart';
import 'package:flutter_ladydenily/features/course_content/data/modles/course_response_module.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  CourseRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses() {
    return _apiClient.get<List<Course>>(
      '${ApiConstants.baseUrl}/course/all-courses',
      fromJsonT: (json) {
        if (json == null) return <Course>[];

        if (json is Map<String, dynamic> && json['course'] is List) {
          final list = json['course'] as List;
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        if (json is List) {
          return json
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        if (json is Map<String, dynamic> &&
            json['data'] is Map &&
            (json['data'] as Map)['course'] is List) {
          final list = (json['data'] as Map)['course'] as List;
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <Course>[];
      },
    );
  }

  // ---- Added to satisfy CourseRepository interface ----
  @override
  NetworkResult<List<CourseResponse>> getAllCourses() {
    return _apiClient.get<List<CourseResponse>>(
      ApiConstants.course.getAllCourses,
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }

  // ---- Added methods for course_content (NetworkResult based) ----
  // Note: these use the same ApiClient instance. They are added here
  // alongside existing code as requested.

  NetworkResult<List<CourseResponse>> getAllCoursesContent() {
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
