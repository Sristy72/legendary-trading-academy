import '../../../../core/network/network_result.dart';
import '../../data/models/get_profile_response_model.dart';

abstract class ProfileRepository {
  NetworkResult<FetchProfileResponseModdel> fetchProfile();
}
