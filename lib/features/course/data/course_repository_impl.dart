import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/network_result.dart';
import 'package:flutter_ladydenily/features/course_content/data/models/course_response_module.dart';

import '../../../core/network/constants/api_constants.dart';
import '../../../core/network/models/network_failure.dart';
import '../../../core/network/models/network_success.dart';
import '../domain/course_repository.dart';
import '../models/course.dart';
import 'models/assignment_submission_response.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  CourseRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses() {
    return _apiClient.get<List<Course>>(
      '${ApiConstants.baseUrl}/course/all-courses',
      fromJsonT: (json) {
        print('[CourseRepo] Parsing JSON: ${json.runtimeType}');

        if (json == null) {
          print('[CourseRepo] JSON is null, returning empty list');
          return <Course>[];
        }

        // Primary case: json is {"course": [...], "meta": {...}}
        if (json is Map<String, dynamic> && json['course'] is List) {
          final list = json['course'] as List;
          print('[CourseRepo] Found course array with ${list.length} items');
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        // Fallback: json is directly a List
        if (json is List) {
          print('[CourseRepo] JSON is direct list with ${json.length} items');
          return json
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        // Legacy case: nested data.course structure
        if (json is Map<String, dynamic> &&
            json['data'] is Map &&
            (json['data'] as Map)['course'] is List) {
          final list = (json['data'] as Map)['course'] as List;
          print(
            '[CourseRepo] Found nested data.course with ${list.length} items',
          );
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        print('[CourseRepo] No matching pattern, returning empty list');
        print(
          '[CourseRepo] JSON keys: ${json is Map<String, dynamic> ? json.keys : "not a map"}',
        );
        return <Course>[];
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchMyCourses() {
    return _apiClient.get<List<Course>>(
      '${ApiConstants.baseUrl}/course/my-courses',
      fromJsonT: (json) {
        print('[CourseRepo] Parsing My Courses JSON: ${json.runtimeType}');

        if (json == null) {
          return <Course>[];
        }

        // Handle various response structures similar to fetchAllCourses
        List list = [];
        if (json is List) {
          list = json;
        } else if (json is Map<String, dynamic> && json['course'] is List) {
          list = json['course'] as List;
        } else if (json is Map<String, dynamic> && json['data'] is List) {
          list = json['data'] as List;
        }

        print('[CourseRepo] Found ${list.length} my courses');
        return list
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList();
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
  Future<Either<NetworkFailure, NetworkSuccess<AssignmentSubmissionResponse>>>
  submitAssignment({
    required String moduleId,
    required String assignmentId,
    required File file,
  }) async {
    try {
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        'moduleId': moduleId,
        'assignmentId': assignmentId,
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      return _apiClient.postFormData<AssignmentSubmissionResponse>(
        ApiConstants.course.submitAssignment,
        formData: formData,
        fromJsonT: (json) {
          return AssignmentSubmissionResponse.fromJson(
            json as Map<String, dynamic>,
          );
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
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

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  createPayment({
    required String userId,
    required num price,
    required String courseId,
    required String type,
  }) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/create-payment';
    print(
      '[CourseRepositoryImpl] creating payment for courseId: $courseId, price: $price',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'userId': userId,
        'price': price,
        'courseId': courseId,
        'type': type,
      },
      fromJsonT: (json) {
        // Expecting { invoiceUrl, transactionId, message }
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  confirmPayment({required String invoiceId}) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/confirm-payment';
    print(
      '[CourseRepositoryImpl] confirming payment for invoiceId: $invoiceId',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {'invoiceId': invoiceId},
      fromJsonT: (json) {
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }
}
