import 'package:get/get.dart';

class Module {
  final String title;
  final String description;
  final int recordingsCount;
  bool isCompleted;

  Module({
    required this.title,
    required this.description,
    required this.recordingsCount,
    this.isCompleted = false,
  });
}

class ModulesDetailsController extends GetxController {
  final RxList<Module> modules = <Module>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    modules.addAll([
      Module(
        title: 'Module 1',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        recordingsCount: 8,
      ),
      Module(
        title: 'Module 2',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        recordingsCount: 6,
      ),
      Module(
        title: 'Module 3',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        recordingsCount: 6,
      ),
      Module(
        title: 'Module 4',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        recordingsCount: 6,
      ),
      Module(
        title: 'Module 5',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        recordingsCount: 6,
      ),
    ]);
  }

  void toggleModuleCompletion(int index) {
    modules[index].isCompleted = !modules[index].isCompleted;
    modules.refresh(); // Update the UI
  }
}