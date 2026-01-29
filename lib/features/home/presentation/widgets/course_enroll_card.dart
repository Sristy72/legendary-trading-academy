import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/models/course.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/invoice_webview_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class CourseEnrollCard extends StatelessWidget {
  final Course course;

  const CourseEnrollCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to course details screen
        Get.to(() => const CourseDetailsScreen(), arguments: course);
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 96),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 2)],
        ),
        child: Row(
          children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: (() {
              final imageUrl = course.photo == null
                  ? ''
                  : course.photo is String
                      ? course.photo as String
                      : (course.photo as dynamic).url ?? '';

              // Fallback widget for when image fails to load
              Widget fallbackWidget = SizedBox(
                width: 120,
                height: 96,
                child: Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              );

              if (imageUrl.isEmpty) {
                return fallbackWidget;
              }

              if (imageUrl.startsWith('http')) {
                return Image.network(
                  imageUrl,
                  width: 120,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return fallbackWidget;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 120,
                      height: 96,
                      child: Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Image.asset(
                  imageUrl,
                  width: 120,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return fallbackWidget;
                  },
                );
              }
            }()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                            course.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            course.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${course.modules.length} Modules',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 72,
                            maxWidth: 110,
                          ),
                          child: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _handleEnrollNow(context, course);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              child: const FittedBox(child: Text("Enroll")),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Future<void> _handleEnrollNow(BuildContext context, Course course) async {
    try {
      // Get course controller
      final courseController = Get.find<CourseController>();

      // Get user ID from profile controller
      String userId = '';
      try {
        final profileController = Get.find<ProfileController>();
        userId = profileController.userInfo.value?.id ?? '';
      } catch (_) {
        userId = '';
      }

      if (userId.isEmpty) {
        Get.snackbar('Error', 'Please login to enroll in courses');
        return;
      }

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Create payment
      final paymentDetails = await courseController.createPaymentForCourse(
        userId: userId,
        price: course.offerPrice > 0 ? course.offerPrice : course.price,
        courseId: course.id,
        type: 'course',
      );

      // Dismiss loading
      Get.back();

      if (paymentDetails != null && paymentDetails['invoiceUrl'] != null) {
        final invoiceUrl = paymentDetails['invoiceUrl']!;
        final transactionId = paymentDetails['transactionId'];

        // Open webview with invoiceUrl and transactionId
        Get.to(
          () => InvoiceWebViewScreen(
            invoiceUrl: invoiceUrl,
            transactionId: transactionId,
          ),
        );
      } else {
        // Show error feedback
        Get.snackbar('Payment Error', 'Unable to create invoice.');
      }
    } catch (e) {
      // Dismiss loading if still showing
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar('Error', 'Failed to process enrollment: $e');
    }
  }
}
