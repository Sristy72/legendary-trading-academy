import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';
import 'package:flutter_ladydenily/features/community/models/chat_message.dart';

abstract class CommunityRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<CommunityItem>>>>
  fetchCommunityList();

  Future<Either<NetworkFailure, NetworkSuccess<List<ChatMessage>>>>
  getMessages(String chatId);

  Future<Either<NetworkFailure, NetworkSuccess<ChatMessage>>> sendMessage({
    required String chatId,
    required String content,
    required String contentType,
    required String participantId,
  });
}
