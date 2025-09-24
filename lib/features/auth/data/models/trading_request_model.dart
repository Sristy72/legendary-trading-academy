import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';
import 'package:flutter_ladydenily/features/auth/data/models/trading_request_model.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

import 'different_user_model.dart';

class UploadImageRequestModel {
  final String? name;
  final int? age;
  final String? phone;
  final String? gender;
  final String? nationality;
  final String? address;
  final TredingProfile tradingProfile;
  final MultipartFile? file; // in case you upload an image/file

  UploadImageRequestModel ({
    this.name,
    this.age,
    this.phone,
    this.gender,
    this.nationality,
    this.address,
    required this.tradingProfile,
    this.file,
  });

  Future<FormData> toFormData() async {
    return FormData({
      if(name != null) "name": name,
      if(age != null) "age": age.toString(),
      if(phone != null) "phone": phone,
      if(gender != null) "gender": gender,
      if(nationality != null) "nationality": nationality,
      if(address != null) "address": address,
      "treding_profile": tradingProfile,
      if(file!= null) "file": file,
    });
  }
}