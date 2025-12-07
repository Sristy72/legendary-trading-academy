import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recording_details_controller.dart';
import '../widgets/module_all_videos.dart';
import '../widgets/inline_video_player.dart';

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
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          if (controller.isFullScreen.value) {
            // Exit fullscreen
            controller.isFullScreen.value = false;
            // Also need to reset SystemChrome, but we don't have direct access here easily
            // unless we toggle via controller... wait.
            // When we set controller.isFullScreen = false, RecordingDetailsScreen rebuilds to Portrait.
            // But VideoPlayerGetxController inside InlineVideoPlayer needs to know to reset SystemChrome.
            // Actually, simply setting controller.isFullScreen=false changes layout, 
            // but the InlineVideoPlayer might still be in Landscape preferred mode.
            // Ideally we should call toggleFullScreen on the VIDEO controller.
            
            // However, we don't have easy access to video controller instance.
            // BUT InlineVideoPlayer listens to widget.isFullScreen? No.
            // VideoPlayerGetxController is the one setting SystemChrome.
            
            // Alternative:
            // Just return true to pop if not fullscreen.
          } else {
             Get.back();
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
      ),
    );
  }
}
