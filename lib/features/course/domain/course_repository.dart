import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
// added imports for course_content APIs
import 'package:flutter_ladydenily/core/network/network_result.dart';

import '../../course_content/data/models/course_response_module.dart';
import '../data/models/assignment_submission_response.dart';
import '../models/course.dart';

abstract class CourseRepository {
  // existing course feature API
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses();

  /// Fetch courses purchased by the user
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>> fetchMyCourses();

  // course_content related APIs (returns NetworkResult wrappers)
  NetworkResult<List<CourseResponse>> getAllCourses();
  NetworkResult<CourseResponse> getCourseDetails(String courseId);
  NetworkResult<List<CourseResponse>> getCourseModules(String moduleId);

  /// Create payment for a course. Returns NetworkSuccess with
  /// a Map containing keys: invoiceUrl, transactionId, message
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  createPayment({
    required String userId,
    required num price,
    required String courseId,
    required String type,
  });

  /// Confirm payment completion with invoice ID
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  confirmPayment({required String invoiceId});
  Future<Either<NetworkFailure, NetworkSuccess<AssignmentSubmissionResponse>>>
  submitAssignment({
    required String moduleId,
    required String assignmentId,
    required File file,
  });
}
