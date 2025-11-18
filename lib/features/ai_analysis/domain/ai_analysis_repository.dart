import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/ai_analysis/data/models/ai_analysis_response.dart';

abstract class AiAnalysisRepository {
  Future<Either<NetworkFailure, NetworkSuccess<AiAnalysisResponse>>>
  analyzeTrade(FormData formData);
}
