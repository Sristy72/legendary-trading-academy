import 'dart:io';

import 'package:flutter_ladydenily/core/network/services/multiple_form_data_manager.dart';
import 'package:flutter_ladydenily/features/ai_analysis/domain/ai_analysis_repository.dart';
import 'package:get/get.dart';

class AiAnalysisController extends GetxController {
  final AiAnalysisRepository repository;

  AiAnalysisController({required this.repository});

  final MultiFormDataManager _multiFormDataManager = MultiFormDataManager();

  final isAnalyzing = false.obs;
  final analysisResult = Rxn<String>();
  final errorMessage = ''.obs;

  Future<void> analyzeTradeImage(File image) async {
    try {
      isAnalyzing.value = true;
      errorMessage.value = '';
      analysisResult.value = null;

      print(
        '[AiAnalysisController] Starting analysis for image: ${image.path}',
      );

      // Prepare form data with image
      _multiFormDataManager.clear();
      _multiFormDataManager.addImageFile(image, key: 'image');

      final formData = await _multiFormDataManager.toFormDataAsync();

      print('[AiAnalysisController] Form data prepared, calling repository');

      final result = await repository.analyzeTrade(formData);

      result.fold(
        (failure) {
          print('[AiAnalysisController] Analysis failed: ${failure.message}');
          errorMessage.value = failure.message;
          analysisResult.value = null;
        },
        (success) {
          print('[AiAnalysisController] Analysis successful');
          analysisResult.value = success.data.analysis;
          errorMessage.value = '';
        },
      );
    } catch (e) {
      print('[AiAnalysisController] Exception during analysis: $e');
      errorMessage.value = 'Failed to analyze image: $e';
      analysisResult.value = null;
    } finally {
      isAnalyzing.value = false;
      _multiFormDataManager.clear();
    }
  }

  void clearAnalysis() {
    analysisResult.value = null;
    errorMessage.value = '';
  }
}
