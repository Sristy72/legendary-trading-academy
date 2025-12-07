import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerGetxController extends GetxController {
  final String videoUrl;

  late VideoPlayerController videoController;
  final isInitialized = false.obs;
  final isPlaying = false.obs;
  final isFullScreen = false.obs;
  final playbackSpeed = 1.0.obs;
  final selectedQuality = "720p".obs;

  VideoPlayerGetxController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController.initialize();
    videoController.setLooping(true);
    videoController.play();

    isInitialized.value = true;
    isPlaying.value = true;

    videoController.addListener(() {
      isPlaying.value = videoController.value.isPlaying;
    });
  }

  // Toggle play/pause
  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    isPlaying.value = videoController.value.isPlaying;
  }

  // Toggle full screen and orientation
  void toggleFullScreen() async {
    if (isFullScreen.value) {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual, overlays: SystemUiOverlay.values);
    } else {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
    isFullScreen.toggle();
  }

  // Auto-detect orientation
  void handleOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape && !isFullScreen.value) {
      isFullScreen.value = true;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else if (orientation == Orientation.portrait && isFullScreen.value) {
      isFullScreen.value = false;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  void changePlaybackSpeed(double speed) {
    playbackSpeed.value = speed;
    videoController.setPlaybackSpeed(speed);
  }

  void changeQuality(String quality) {
    selectedQuality.value = quality;
  }

  // Settings bottom sheet
  void showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A386D), // Approx blue from image
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               // Handle
               Center(
                 child: Container(
                   width: 40,
                   height: 4,
                   decoration: BoxDecoration(
                     color: Colors.grey[400],
                     borderRadius: BorderRadius.circular(2),
                   ),
                 ),
               ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.speed, color: Colors.white),
                title: const Text("Playback Speed",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: Obx(() => Text("${playbackSpeed.value}x",
                    style: const TextStyle(color: Colors.white70))),
                onTap: () {
                   Navigator.pop(context);
                   _showSpeedOptions(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.hd, color: Colors.white),
                title: const Text("Quality",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: Obx(() => Text(selectedQuality.value,
                    style: const TextStyle(color: Colors.white70))),
                onTap: () {
                   Navigator.pop(context);
                   _showQualityOptions(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showSpeedOptions(BuildContext context) {
    final speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A386D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
         padding: const EdgeInsets.symmetric(vertical: 8),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             // Header with back button
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
               child: Row(
                 children: [
                   IconButton(
                     icon: const Icon(Icons.arrow_back, color: Colors.white),
                     onPressed: () {
                        Navigator.pop(context);
                        showSettings(context); // Go back to main settings
                     },
                   ),
                   const Text("Playback Speed", 
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                 ],
               ),
             ),
             const Divider(color: Colors.white24),
             Flexible(
               child: ListView(
                shrinkWrap: true,
                children: speeds
                    .map((s) => Obx(() => RadioListTile<double>(
                  value: s,
                  groupValue: playbackSpeed.value,
                  onChanged: (val) {
                    if (val != null) {
                      Navigator.pop(context); // Close sheet
                      changePlaybackSpeed(val);
                    }
                  },
                  title: Text("${s}x", // Remove .0 for integers? design shows 1 not 1.0 but 0.25 is fine
                      style: const TextStyle(color: Colors.white)),
                  activeColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  controlAffinity: ListTileControlAffinity.trailing, // Checkbox on right
                )))
                    .toList(),
               ),
             ),
           ],
         ),
      ),
    );
  }

  void _showQualityOptions(BuildContext context) {
    final qualities = ["Auto", "1080p", "720p"];
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A386D),
       shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
         padding: const EdgeInsets.symmetric(vertical: 8),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
              // Header with back button
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
               child: Row(
                 children: [
                   IconButton(
                     icon: const Icon(Icons.arrow_back, color: Colors.white),
                     onPressed: () {
                        Navigator.pop(context);
                        showSettings(context); // Go back to main settings
                     },
                   ),
                   const Text("Quality", 
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                 ],
               ),
             ),
             const Divider(color: Colors.white24),
             Flexible(
               child: ListView(
                shrinkWrap: true,
                children: qualities
                    .map((q) => Obx(() => RadioListTile<String>(
                  value: q,
                  groupValue: selectedQuality.value,
                  onChanged: (val) {
                    if (val != null) {
                      Navigator.pop(context);
                      changeQuality(val);
                    }
                  },
                  title:
                  Text(q, style: const TextStyle(color: Colors.white)),
                  activeColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  controlAffinity: ListTileControlAffinity.trailing,
                )))
                    .toList(),
               ),
             ),
           ],
         ),
      ),
    );
  }

  @override
  void onClose() {
    videoController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }
}
