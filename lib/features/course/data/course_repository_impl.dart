import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';

import '../../../core/network/constants/api_constants.dart';
import '../../../core/network/models/network_failure.dart';
import '../../../core/network/models/network_success.dart';
import '../domain/course_repository.dart';
import '../models/course.dart';

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
}
