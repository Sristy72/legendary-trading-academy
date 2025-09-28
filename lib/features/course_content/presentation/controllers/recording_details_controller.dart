import 'package:get/get.dart';

import '../../../../core/base/base_controller.dart';
import '../../../course/domain/course_repository.dart';
import '../../data/modles/video_model.dart';
import '../../data/modules/course_response_module.dart';


class RecordingDetailsController extends BaseController {
  final CourseRepository _repository;

  RecordingDetailsController({required CourseRepository repository})
    : _repository = repository;

  final RxList<VideoItem> _allVideos = <VideoItem>[].obs;
  final Rx<CourseResponse?> _selectedCourse = Rx<CourseResponse?>(null);

  List<VideoItem> get allVideos => _allVideos;
  CourseResponse? get selectedCourse => _selectedCourse.value;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    final String courseId = (arg is String && arg.isNotEmpty)
        ? arg
        : '68bd6ef27cbf6a866f314d98';
    getCourseRecordings(courseId);
  }

  Future<void> getCourseRecordings(String courseId) async {
    setLoading(true);
    try {
      final dynamic result = await _repository.getCourseDetails(courseId);

      CourseResponse? course;
      if (result is CourseResponse) {
        course = result;
      }
      else if (result is Map) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(result);
        final dynamic payload = map['data'] ?? map;
        if (payload is Map) {
          course = CourseResponse.fromJson(Map<String, dynamic>.from(payload));
        }
      }
      else {
        try {
          final dynamic payload =
              (result as dynamic).data ??
              (result as dynamic).response ??
              (result as dynamic).result;
          if (payload is CourseResponse) {
            course = payload;
          } else if (payload is Map) {
            course = CourseResponse.fromJson(
              Map<String, dynamic>.from(payload),
            );
          } else if (result is Map<String, dynamic>) {
            final Map<String, dynamic> map = Map<String, dynamic>.from(result);
            final dynamic p = map['data'] ?? map;
            if (p is Map)
              course = CourseResponse.fromJson(Map<String, dynamic>.from(p));
          }
        } catch (_) {
        }
      }

      if (course != null) {
        _selectedCourse.value = course;
        _extractAllVideos(course);
      } else {
        setError('Failed to parse course details');
      }
    } catch (e) {
      setError('Failed to load course recordings: $e');
    } finally {
      setLoading(false);
    }
  }

  void _extractAllVideos(CourseResponse course) {
    final List<VideoItem> videos = [];

    for (final module in course.modules) {
      videos.addAll(module.video);
    }

    _allVideos.assignAll(videos);
  }

  void refreshRecordings() {
    final arg = Get.arguments;
    final String courseId = (arg is String && arg.isNotEmpty)
        ? arg
        : '68bd6ef27cbf6a866f314d98';
    if (courseId.isNotEmpty) {
      getCourseRecordings(courseId);
    }
  }
}
