import 'package:flutter_ladydenily/core/utils/debug_print.dart';
import 'package:flutter_ladydenily/features/profile/data/models/get_profile_response_model.dart';
import 'package:flutter_ladydenily/features/profile/domain/repo/profile_repo.dart';
import 'package:get/get.dart';
import '../../../../core/base/base_controller.dart';

class ProfileController extends BaseController {
  final ProfileRepository _profileRepository;
  var isSkipLoading = false.obs;
  var isContinueLoading = false.obs;


  ProfileController(this._profileRepository);

  final Rxn<FetchProfileResponseModdel> userInfo = Rxn<FetchProfileResponseModdel>();
  // Login
  Future<void> fetchProfile() async {
    setLoading(true);
    setError("");

    final result = await _profileRepository.fetchProfile();


    result.fold((fail) {
      setError(fail.message);
      DPrint.log('data fetch failed');
      setLoading(false);
    }, (success) {
      userInfo.value = success.data;
      DPrint.log(success.message);
      setLoading(false);
    });
  }
}
