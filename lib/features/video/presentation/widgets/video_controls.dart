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

    return Stack(
      children: [
        // Center Controls (Rewind, Play/Pause, Forward)
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               IconButton(
                 onPressed: () {
                   final current = videoCtrl.value.position;
                   videoCtrl.seekTo(current - const Duration(seconds: 10));
                 },
                 icon: const Icon(Icons.replay_10, color: Colors.white, size: 36),
               ),
               const SizedBox(width: 20),
               GestureDetector(
                onTap: controller.togglePlayPause,
                child: Obx(() => Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 48,
                )),
              ),
               const SizedBox(width: 20),
               IconButton(
                 onPressed: () {
                   final current = videoCtrl.value.position;
                   videoCtrl.seekTo(current + const Duration(seconds: 10));
                 },
                 icon: const Icon(Icons.forward_10, color: Colors.white, size: 36),
               ),
            ],
          ),
        ),

        // Bottom Bar (Progress + Time + Fullscreen)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent, // Or gradient if needed
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Time and Fullscreen
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: videoCtrl,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          "${_formatDuration(value.position)} / ${_formatDuration(value.duration)}",
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        );
                      },
                    ),
                    const Spacer(),
                    
                    // Volume Icon (Placeholder as logic not fully there yet, but in image)
                    const Icon(Icons.volume_up, color: Colors.white, size: 20),
                    const SizedBox(width: 16),
                    
                    IconButton(
                      onPressed: controller.toggleFullScreen,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.fullscreen, color: Colors.white, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Progress Bar
                VideoProgressIndicator(
                  videoCtrl,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.grey[300]!, // Light grey played
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white12,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
        
        // Settings Icon (Top Right)
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => controller.showSettings(context),
          ),
        ),
        
        // Back Button (Top Left) - Only if fullscreen or needed
        Obx(() {
           if (controller.isFullScreen.value) {
             return Positioned(
               top: 16,
               left: 16,
               child: IconButton(
                 icon: const Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: controller.toggleFullScreen, 
               ),
             );
           }
           return const SizedBox.shrink();
        }),
      ],
    );
  }
}
