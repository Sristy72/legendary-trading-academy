import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:get/get.dart';

import '../controllers/recording_details_controller.dart';
import '../widgets/inline_video_player.dart';
import '../widgets/module_all_videos.dart';

class RecordingDetailsScreen extends StatelessWidget {
  const RecordingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordingDetailsController controller = Get.put(
      RecordingDetailsController(repository: Get.find()),
    );

    return AppScaffold(
      removePadding: true,
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
        // Check fullscreen state from controller
        final isFullScreen = controller.isFullScreen.value;

        return PopScope(
          canPop: !isFullScreen,
          onPopInvoked: (didPop) async {
            if (didPop) return;
            if (isFullScreen) {
              // Exit fullscreen instead of going back
              controller.isFullScreen.value = false;
            }
          },
          child: Obx(() {
            // Check fullscreen state from controller
            final isFullScreen = controller.isFullScreen.value;

          return Column(
            children: [
              // Video Player Section
              Obx(() {
                final videoUrl = controller.currentVideoUrl.value;
                if (videoUrl == null || videoUrl.isEmpty) {
                   if (isFullScreen) return const SizedBox.shrink(); 
                   return const SizedBox.shrink();
                }
                
                Widget player = InlineVideoPlayer(
                  videoUrl: videoUrl,
                  isFullScreen: isFullScreen,
                  onFullScreenToggle: (isFull) {
                     controller.isFullScreen.value = isFull;
                  },
                  key: const ValueKey('inline-player'),
                );

                // Use Flexible to prevent widget unmounting/remounting which triggers dispose
                return Flexible(
                  fit: isFullScreen ? FlexFit.tight : FlexFit.loose,
                  child: player,
                );
              }),

              // Hide details and list if FullScreen
              if (!isFullScreen) ...[
                // Video Details Section
                Obx(() {
                   if (controller.currentVideoTitle.value.isEmpty) return const SizedBox.shrink();
                   return Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           controller.currentVideoTitle.value,
                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           controller.currentVideoDate.value,
                           style: const TextStyle(fontSize: 14, color: Colors.grey),
                         ),
                       ],
                     ),
                   );
                }),

                // Modules List
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.modules.isEmpty) {
                      return const Center(child: Text('No recordings found'));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.modules.length,
                      itemBuilder: (context, index) {
                        final module = controller.modules[index];
                        return ModuleAllVideos(
                          index: index, 
                          module: module,
                          onVideoTap: (url, title, date) {
                              controller.playVideo(url, title, date);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    );
                  }),
                ),
              ],
            ],
          );
        }),
        );
      }),
    );
  }
}
