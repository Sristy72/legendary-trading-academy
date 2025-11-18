import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/constants/api_constants.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/ai_analysis/data/models/ai_analysis_response.dart';
import 'package:flutter_ladydenily/features/ai_analysis/domain/ai_analysis_repository.dart';

class AiAnalysisRepositoryImpl implements AiAnalysisRepository {
  final ApiClient _apiClient;

  AiAnalysisRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<AiAnalysisResponse>>>
  analyzeTrade(FormData formData) async {
    print('[AiAnalysisRepositoryImpl] analyzing trade with image');

    return _apiClient.post<AiAnalysisResponse>(
      '${ApiConstants.baseUrl}/payment/analyze-trade',
      data: formData,
      fromJsonT: (json) {
        print('[AiAnalysisRepositoryImpl] fromJsonT received: $json');
        if (json == null) {
          return AiAnalysisResponse(analysis: '');
        }
        return AiAnalysisResponse.fromJson(json as Map<String, dynamic>);
      },
    );
  }
}
