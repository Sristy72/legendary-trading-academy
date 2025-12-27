import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/ai_analysis_controller.dart';

class AiAnalysisScreen extends StatefulWidget {
  const AiAnalysisScreen({super.key});

  @override
  State<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends State<AiAnalysisScreen> {
  final ImagePicker _picker = ImagePicker();
  final AiAnalysisController controller = Get.find<AiAnalysisController>();
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        controller.clearAnalysis(); // Reset previous analysis
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image from gallery: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _captureImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        controller.clearAnalysis(); // Reset previous analysis
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image from camera: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) {
      Get.snackbar(
        'No Image',
        'Please select an image first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
      );
      return;
    }

    await controller.analyzeTradeImage(_selectedImage!);

    if (controller.errorMessage.value.isNotEmpty) {
      Get.snackbar(
        'Error',
        controller.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } else if (controller.analysisResult.value != null) {
      Get.snackbar(
        'Analysis Complete',
        'AI analysis generated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
      );
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
    controller.clearAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Image Analysis',
          style: TextStyle(
            color: AppColors.titleTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.titleTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow.shade700.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.yellow.shade700.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.yellow.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Upload a trading chart or financial data image for AI-powered analysis',
                      style: TextStyle(
                        color: AppColors.textColorBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Image preview or placeholder
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.contain)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No image selected',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      foregroundColor: AppColors.textColorBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _captureImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      foregroundColor: AppColors.textColorBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Analyze button
            if (_selectedImage != null)
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: controller.isAnalyzing.value
                        ? null
                        : _analyzeImage,
                    icon: controller.isAnalyzing.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(
                      controller.isAnalyzing.value
                          ? 'Analyzing...'
                          : 'Analyze with AI',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      foregroundColor: AppColors.textColorBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ),

            // Prediction result
            Obx(() {
              if (controller.analysisResult.value == null) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.psychology,
                              color: Colors.yellow.shade700,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'AI Analysis',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Text(
                          controller.analysisResult.value!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.titleTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Clear button after prediction
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextButton.icon(
                        onPressed: _clearImage,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear Image'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ),
                ],
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
