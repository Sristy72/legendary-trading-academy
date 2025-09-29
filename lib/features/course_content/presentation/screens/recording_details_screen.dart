import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recording_details_controller.dart';
import '../widgets/module_video_container.dart';

class RecordingDetailsScreen extends StatelessWidget {
  const RecordingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordingDetailsController controller = Get.put(
      RecordingDetailsController(repository: Get.find()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recordings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        debugPrint('Modules: ${controller.modules}');
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.modules.isEmpty) {
          return const Center(child: Text('No recordings found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.modules.length,
          itemBuilder: (context, index) {
            final module = controller.modules[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Module ${index + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: module.video.length,
                  itemBuilder: (context, videoIndex) {
                    final video = module.video[videoIndex];
                    return ModuleVideoContainer(
                      title: video.name ?? 'Video ${videoIndex + 1}',
                      durationText: video.url ?? '',
                      imagePath: 'assets/images/courses_sample.jpg',
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      }),
    );
  }
}
