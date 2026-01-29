import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../course_content/presentation/widgets/module_all_videos.dart';
import '../controllers/ video_controller.dart';
import '../widgets/video_controls.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  /// Full modules list to render below the player
  final List<dynamic> modules;

  /// Which module was tapped on previous screen (for scroll/highlight if needed)
  final int? initialModuleIndex;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.modules,
    this.initialModuleIndex,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPlayerGetxController(videoUrl));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => controller.isFullScreen.value
              ? const SizedBox.shrink()
              : AppBar(
                  title: const Text("Play Video"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: Get.back,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black),
                      onPressed: () => controller.showSettings(context),
                    ),
                  ],
                ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.handleOrientation(orientation);
          });

          return SafeArea(
            child: Obx(() {
              if (!controller.isInitialized.value) {
                // Check if there's an error message
                if (controller.errorMessage.value != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Video Error',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            controller.errorMessage.value ?? '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: Get.back,
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Go Back'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // Loading
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }
              final videoCtrl = controller.videoController;

              // ---- Layout: Player on top, scrollable modules below ----
              return CustomScrollView(
                slivers: [
                  // Player section (sticky-looking top chunk)
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Black player container like the screenshot
                        Container(
                          color: Colors.black,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: videoCtrl.value.aspectRatio > 0
                                    ? videoCtrl.value.aspectRatio
                                    : 16 / 9,
                                child: VideoPlayer(videoCtrl),
                              ),
                              // Custom controls (bottom)
                              VideoControls(controller: controller),
                              // Tap to Play/Pause overlay (center, ignore controls)
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 70,
                                child: GestureDetector(
                                  onTap: controller.togglePlayPause,
                                  child: Obx(
                                    () => Icon(
                                      controller.isPlaying.value
                                          ? Icons.pause_circle_filled
                                          : Icons.play_circle_fill,
                                      color: Colors.white.withOpacity(0.85),
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Title + meta row like screenshot (dummy placeholders if needed)
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Lorem ipsum dolor sit egestas.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "24 May 2025 | 2h 44m 31s",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  // Modules list (same component reused)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                    sliver: SliverList.separated(
                      itemCount: modules.length,
                      itemBuilder: (context, index) {
                        final module = modules[index];

                        return GestureDetector(
                          onTap: () {
                            // Tap any module here to switch the playing video to that module's first item
                            final String? nextUrl =
                                (module.videos?.isNotEmpty ?? false)
                                ? module.videos.first.url as String
                                : null;
                            if (nextUrl == null || nextUrl.isEmpty) return;

                            // Re-init the same screen controller with new URL
                            controller.loadNewSource(nextUrl);
                            // Optional: scroll to top for player visibility
                            Scrollable.ensureVisible(
                              context,
                              duration: const Duration(milliseconds: 300),
                              alignment: 0.0,
                            );
                          },
                          child: ModuleAllVideos(
                            index: index,
                            module: module,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
