
import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/calender/models/event_model.dart';

abstract class CalenderRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<EventModel>>>> getEvents(
    String date,
  );
}
