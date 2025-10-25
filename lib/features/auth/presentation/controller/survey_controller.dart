import 'package:get/get.dart';

class SurveyController extends GetxController {
  // Single-choice fields
  var tradingExperience = "".obs;
  var assetOfInterest = "".obs;
  var mainGoal = "".obs;
  var riskAppetite = "".obs;

  // Multi-choice field
  var learningModes = <String>[].obs;

  void selectSingle(RxString field, String label) {
    if (field.value == label) {
      field.value = ""; // unselect if clicked again
    } else {
      field.value = label;
    }
  }

  void toggleLearningMode(String label) {
    if (learningModes.contains(label)) {
      learningModes.remove(label);
    } else {
      learningModes.add(label);
    }
  }
}