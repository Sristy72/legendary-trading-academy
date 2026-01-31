
import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/constants/api_constants.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/calender/data/calender_repository.dart';
import 'package:flutter_ladydenily/features/calender/models/event_model.dart';

class CalenderRepositoryImpl implements CalenderRepository {
  final ApiClient _apiClient;

  CalenderRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<EventModel>>>> getEvents(
    String date,
  ) async {
    return _apiClient.get<List<EventModel>>(
      '${ApiConstants.event.getEvents}?date=$date',
      fromJsonT: (json) {
         print('[CalenderRepo] Raw JSON: $json');
        if (json == null) return [];
        if (json is List) {
           try {
             return json
              .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
              .toList();
           } catch (e) {
              print('[CalenderRepo] Parse error: $e');
              rethrow;
           }
        }
        print('[CalenderRepo] JSON is not a list: ${json.runtimeType}');
        return [];
      },
    );
  }
}
