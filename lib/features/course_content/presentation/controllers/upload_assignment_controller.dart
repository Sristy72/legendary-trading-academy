
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/features/course/data/course_repository_impl.dart';
import 'package:flutter_ladydenily/features/course/domain/course_repository.dart';
import 'package:get/get.dart';

class UploadAssignmentController extends GetxController {
  late final CourseRepository _repository;

  final String moduleId;
  final String assignmentId;

  UploadAssignmentController({
    required this.moduleId,
    required this.assignmentId,
  });

  final RxString fileName = ''.obs;
  final RxString status = 'Pending'.obs;
  File? _selectedFile;
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _repository = CourseRepositoryImpl(apiClient: ApiClient());
  }

  Future<void> pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);
      fileName.value = result.files.single.name;
    }
  }

  Future<void> submit() async {
    if (_selectedFile == null) {
      Get.snackbar('Error', 'Please select a file first');
      return;
    }

    isSubmitting.value = true;

    final result = await _repository.submitAssignment(
      moduleId: moduleId,
      assignmentId: assignmentId,
      file: _selectedFile!,
    );

    isSubmitting.value = false;

    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (success) {
        status.value = 'Uploaded';
        Get.snackbar(
          'Success',
          'Assignment submitted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      },
    );
  }
}
