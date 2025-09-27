import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import '../models/course.dart';

abstract class CourseRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses();
}
