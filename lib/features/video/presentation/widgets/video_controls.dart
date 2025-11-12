import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/ video_controller.dart';

class VideoControls extends StatelessWidget {
  final VideoPlayerGetxController controller;
  const VideoControls({super.key, required this.controller});

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final videoCtrl = controller.videoController;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Progress bar
            SizedBox(
              width: double.infinity,
              child: VideoProgressIndicator(
                videoCtrl,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Colors.redAccent,
                  bufferedColor: Colors.white38,
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Bottom control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Time info - Use ValueListenableBuilder for VideoPlayerController
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: videoCtrl,
                    builder: (context, VideoPlayerValue value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${_formatDuration(value.position)} / ${_formatDuration(value.duration)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: controller.togglePlayPause,
                        splashRadius: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.toggleFullScreen,
                      icon: Obx(
                        () => Icon(
                          controller.isFullScreen.value
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      splashRadius: 24,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
