import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repo/profile_repo.dart';
import '../models/get_profile_response_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<FetchProfileResponseModdel> fetchProfile() {
    return _apiClient.get(
        ApiConstants.user.getUserProfile,
        fromJsonT: (json) => FetchProfileResponseModdel.fromJson(json as Map<String, dynamic>));
  }
}
