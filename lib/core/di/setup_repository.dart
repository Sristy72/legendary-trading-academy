import 'package:flutter_ladydenily/features/profile/data/repo/profile_repo_impl.dart';
import 'package:flutter_ladydenily/features/profile/domain/repo/profile_repo.dart';
import 'package:get/get.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/domain/repo/auth_repo.dart';

void setupRepository() {
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(apiClient: Get.find()));
  Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(apiClient: Get.find()));
}
