import 'package:get/get.dart';
import 'package:flutx_core/flutx_core.dart';
import '../../../../core/base/base_controller.dart';
import '../../data/modules/class_module_module.dart';
import '../../data/modules/course_response_module.dart';
import '../../domain/course_repo.dart';

class ModulesDetailsController extends BaseController {
  final CourseRepository _courseRepository;

  ModulesDetailsController(this._courseRepository);

  // Observable data
  final RxList<Module> _modules = <Module>[].obs;
  final Rx<CourseResponse?> _courseDetails = Rx<CourseResponse?>(null);
  final RxMap<String, bool> _completionStatus = <String, bool>{}.obs;

  // Getters
  List<Module> get modules => _modules.toList();
  CourseResponse? get courseDetails => _courseDetails.value;
  Map<String, bool> get completionStatus => _completionStatus;

  @override
  void onInit() {
    super.onInit();
    // Load modules from arguments if available
    final courseId = Get.arguments as String?;
    if (courseId != null) {
      getCourseDetails(courseId);
    } else {
      // Load sample data if no course ID provided
      // _loadSampleData();
    }
  }

  // void _loadSampleData() {
  //   final sampleModules = [
  //     Module(
  //       id: '1',
  //       name: 'Module 1',
  //       video: [],
  //       resources: [],
  //       assignment: [],
  //     ),
  //     Module(
  //       id: '2',
  //       name: 'Module 2',
  //       video: [],
  //       resources: [],
  //       assignment: [],
  //     ),
  //     Module(
  //       id: '3',
  //       name: 'Module 3',
  //       video: [],
  //       resources: [],
  //       assignment: [],
  //     ),
  //     Module(
  //       id: '4',
  //       name: 'Module 4',
  //       video: [],
  //       resources: [],
  //       assignment: [],
  //     ),
  //     Module(
  //       id: '5',
  //       name: 'Module 5',
  //       video: [],
  //       resources: [],
  //       assignment: [],
  //     ),
  //   ];

  //   _modules.value = sampleModules;

  //   // Initialize completion status
  //   for (var module in sampleModules) {
  //     _completionStatus[module.id] = false;
  //   }
  // }

  Future<void> getCourseDetails(String courseId) async {
    setLoading(true);
    setError("");

    final result = await _courseRepository.getCourseDetails(courseId);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("Get course details failed: ${fail.message}");
        setLoading(false);
        // Load sample data as fallback
        // _loadSampleData();
      },
      (success) {
        _courseDetails.value = success.data;
        _modules.value = success.data.modules;

        // Initialize completion status for all modules
        for (var module in success.data.modules) {
          _completionStatus[module.id] = false;
        }

        DPrint.log("Get course details success: ${success.data.name}");
        setLoading(false);
      },
    );
  }

  void toggleModuleCompletion(String moduleId) {
    _completionStatus[moduleId] = !(_completionStatus[moduleId] ?? false);
    _completionStatus.refresh();
  }

  bool isModuleCompleted(String moduleId) {
    return _completionStatus[moduleId] ?? false;
  }

  int get completedModulesCount {
    return _completionStatus.values.where((completed) => completed).length;
  }

  double get progressPercentage {
    if (_modules.isEmpty) return 0.0;
    return completedModulesCount / _modules.length;
  }

  void refreshModules() {
    if (_courseDetails.value != null) {
      getCourseDetails(_courseDetails.value!.id);
    }
  }
}
