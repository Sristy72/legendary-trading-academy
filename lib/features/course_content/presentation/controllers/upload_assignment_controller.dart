import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    _repository = Get.find<CourseRepository>();
  }

  Future<void> pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);
      fileName.value = result.files.single.name;
    }
  }

  Future<void> submit() async {
    if (_selectedFile == null) {
      Get.snackbar(
        'Error',
        'Please select a file first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF5350),
        colorText: const Color(0xFFFFFFFF),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error_outline, color: Color(0xFFFFFFFF)),
      );
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
          '❌ Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF5350),
          colorText: const Color(0xFFFFFFFF),
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.error_outline, color: Color(0xFFFFFFFF)),
        );
      },
      (success) {
        status.value = 'Uploaded';
        Get.snackbar(
          '✅ Success',
          'Assignment submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: const Color(0xFFFFFFFF),
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.check_circle_outline,
            color: Color(0xFFFFFFFF),
          ),
        );

        // Log the response data for debugging
        print('Assignment submitted: ${success.data.title}');
        print('Submission ID: ${success.data.id}');
        if (success.data.submission.isNotEmpty) {
          print('Submitted at: ${success.data.submission.first.submittedAt}');
        }

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      },
    );
  }
}
