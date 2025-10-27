import 'package:flutter_ladydenily/features/community/models/community_item.dart';

abstract class CommunityRepository {
  Future<List<CommunityItem>> fetchCommunityList();
}
