import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import '../models/marketplace_item_api_model.dart';

abstract class MarketplaceRepository {
  Future<Either<NetworkFailure, NetworkSuccess<List<MarketplaceItemApiModel>>>>
  fetchAllMarketplaceItems();
  Future<Either<NetworkFailure, NetworkSuccess<MarketplaceItemApiModel>>>
  fetchMarketplaceItemById(String id);
}
