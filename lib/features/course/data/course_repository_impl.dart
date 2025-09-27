import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';

import '../../../core/network/constants/api_constants.dart';
import '../../../core/network/models/network_failure.dart';
import '../../../core/network/models/network_success.dart';
import '../domain/course_repository.dart';
import '../models/api_course.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  CourseRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<ApiCourse>>>>
  fetchAllCourses() {
    return _apiClient.get<List<ApiCourse>>(
      '${ApiConstants.baseUrl}/course/all-courses',
      fromJsonT: (json) {
        final data = json['data'];
        if (data != null && data['course'] is List) {
          final list = data['course'] as List;
          return list
              .map((e) => ApiCourse.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <ApiCourse>[];
      },
    );
  }
}
