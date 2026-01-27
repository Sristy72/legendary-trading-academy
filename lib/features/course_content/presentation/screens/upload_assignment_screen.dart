import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/upload_assignment_controller.dart';

class UploadAssignmentScreen extends StatelessWidget {
  final String assignmentTitle;
  final String moduleId;
  final String assignmentId;

  const UploadAssignmentScreen({
    super.key, 
    required this.assignmentTitle,
    required this.moduleId,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context) {
    // Putting logic here requires passing IDs, using tag or creating unique instance
    final controller = Get.put(
      UploadAssignmentController(moduleId: moduleId, assignmentId: assignmentId),
      tag: assignmentId, // Use tag to allow multiple assignment streams
    );

    // Check submission status on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If status is already 'Uploaded', show the snackbar
      if (controller.status.value == 'Uploaded') {
        Get.snackbar(
          '✅ Already Submitted',
          'You have already submitted this assignment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(assignmentTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5EAF2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Assignment Details', // Simplified header
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Obx(() {
                              final isSubmitted =
                                  controller.status.value == 'Uploaded';
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSubmitted
                                      ? const Color(0xFFDFF5E1)
                                      : const Color(0xFFFFF5D9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  controller.status.value,
                                  style: TextStyle(
                                    color: isSubmitted
                                        ? const Color(0xFF2E7D32)
                                        : Colors.black54,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Select your file below to submit this assignment.',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => controller.pickAndUpload(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE5EAF2),
                          style: BorderStyle.solid,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => Text(
                                controller.fileName.value.isEmpty
                                    ? 'Upload Your Work'
                                    : controller.fileName.value,
                                style: const TextStyle(color: Colors.blueGrey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withOpacity(0.1),
            ),
            child: Obx(() {
               if (controller.isSubmitting.value) {
                 return const Center(child: CircularProgressIndicator(color: AppColors.buttonColor));
               }
               return Column(
                 children: [
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.buttonColor,
                       minimumSize: const Size.fromHeight(45),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8),
                       ),
                     ),
                     onPressed: () {
                       if (controller.status.value == 'Uploaded') {
                         Get.snackbar(
                           '✅ Already Submitted',
                           'You have already submitted this assignment',
                           snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: const Color(0xFF4CAF50),
                           colorText: Colors.white,
                           borderRadius: 8,
                           margin: const EdgeInsets.all(16),
                           duration: const Duration(seconds: 3),
                           icon: const Icon(Icons.check_circle, color: Colors.white),
                         );
                       } else {
                         Get.snackbar(
                           '📤 Submitting',
                           'Your assignment is being submitted...',
                           snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: const Color(0xFF1976D2),
                           colorText: Colors.white,
                           borderRadius: 8,
                           margin: const EdgeInsets.all(16),
                           duration: const Duration(seconds: 2),
                           icon: const Icon(Icons.upload_file, color: Colors.white),
                         );
                         controller.submit().then((_) {
                           // Check if already submitted error occurred
                           Future.delayed(const Duration(milliseconds: 500), () {
                             if (controller.status.value == 'Uploaded') {
                               Get.snackbar(
                                 '✅ Already Submitted',
                                 'You have already submitted this assignment',
                                 snackPosition: SnackPosition.BOTTOM,
                                 backgroundColor: const Color(0xFF4CAF50),
                                 colorText: Colors.white,
                                 borderRadius: 8,
                                 margin: const EdgeInsets.all(16),
                                 duration: const Duration(seconds: 3),
                                 icon: const Icon(Icons.check_circle, color: Colors.white),
                               );
                             }
                           });
                         });
                       }
                     },
                     child: const Text(
                       'Submit Assignment',
                       style: TextStyle(
                         color: Color(0xff1A3E74),
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                   ),
                   const SizedBox(height: 20),
                 ],
               );
            }),
            
          ),
        ],
      ),
    );
  }
}
