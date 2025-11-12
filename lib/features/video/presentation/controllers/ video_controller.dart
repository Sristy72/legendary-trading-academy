import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import '../../../video/data/utils/video_url_helper.dart';

class VideoPlayerGetxController extends GetxController
    with WidgetsBindingObserver {
  final String videoUrl;

  late VideoPlayerController videoController;

  // Reactive state
  final isInitialized = false.obs;
  final isPlaying = false.obs;
  final isFullScreen = false.obs;
  final isBuffering = false.obs;
  final errorMessage = Rx<String?>(null);

  // Progress
  final position = Duration.zero.obs;
  final duration = Duration.zero.obs;

  // Settings
  final playbackSpeed = 1.0.obs;
  final selectedQuality = "720p".obs;

  // Internal
  VoidCallback? _videoListener;

  VideoPlayerGetxController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initializeVideo(videoUrl);
  }

  // ---------- Core Init / Source Switching ----------
  Future<void> _initializeVideo(String url) async {
    isInitialized.value = false;
    isBuffering.value = true;
    errorMessage.value = null;

    // Clean up if already set
    if (_hasController) {
      await _teardownController();
    }

    // Check if URL is YouTube
    if (VideoUrlHelper.isYouTubeUrl(url)) {
      final videoId = VideoUrlHelper.extractYouTubeVideoId(url);
      if (videoId != null) {
        errorMessage.value =
            'YouTube videos not directly supported.\n\nPlease use HLS/MP4 streams instead.\n\nVideo ID: $videoId';
        isInitialized.value = false;
        return;
      } else {
        errorMessage.value = 'Invalid YouTube URL';
        isInitialized.value = false;
        return;
      }
    }

    // Process the URL
    final processedUrl = VideoUrlHelper.processVideoUrl(url);
    if (processedUrl == null) {
      errorMessage.value = 'Invalid video URL format';
      isInitialized.value = false;
      return;
    }

    try {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(processedUrl),
      );
      await videoController.initialize();

      duration.value = videoController.value.duration;
      await videoController.setLooping(true);
      await videoController.setPlaybackSpeed(playbackSpeed.value);

      // Listener
      _videoListener = () {
        final value = videoController.value;
        isPlaying.value = value.isPlaying;
        isBuffering.value = value.isBuffering;
        position.value = value.position;
        duration.value = value.duration;
      };
      videoController.addListener(_videoListener!);

      isInitialized.value = true;
      errorMessage.value = null;
      play();
    } catch (e) {
      errorMessage.value = 'Failed to load video: $e';
      isInitialized.value = false;
    }
  }

  Future<void> loadNewSource(String url) async {
    // keep fullscreen/state, just swap media
    await _initializeVideo(url);
  }

  bool get _hasController {
    try {
      // access may throw if never initialized
      // ignore: unnecessary_null_comparison
      return videoController != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> _teardownController() async {
    try {
      videoController.removeListener(_videoListener ?? () {});
      await videoController.pause();
      await videoController.dispose();
    } catch (_) {}
  }

  // ---------- Playback ----------
  Future<void> play() async {
    if (!isInitialized.value) return;
    await videoController.play();
    isPlaying.value = true;
  }

  Future<void> pause() async {
    if (!isInitialized.value) return;
    await videoController.pause();
    isPlaying.value = false;
  }

  Future<void> togglePlayPause() async {
    if (!isInitialized.value) return;
    if (videoController.value.isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> seekTo(Duration target) async {
    if (!isInitialized.value) return;
    final dur = duration.value;
    final clamped = target < Duration.zero
        ? Duration.zero
        : (target > dur ? dur : target);
    await videoController.seekTo(clamped);
  }

  // ---------- Fullscreen / Orientation ----------
  Future<void> toggleFullScreen() async {
    if (isFullScreen.value) {
      await _exitFullscreen();
    } else {
      await _enterFullscreen();
    }
    isFullScreen.toggle();
  }

  Future<void> _enterFullscreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _exitFullscreen() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  // Call from OrientationBuilder
  void handleOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape && !isFullScreen.value) {
      isFullScreen.value = true;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else if (orientation == Orientation.portrait && isFullScreen.value) {
      isFullScreen.value = false;
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  // ---------- Settings ----------
  Future<void> changePlaybackSpeed(double speed) async {
    playbackSpeed.value = speed;
    if (isInitialized.value) {
      await videoController.setPlaybackSpeed(speed);
    }
  }

  // Stub: hook your HLS/DASH quality logic here if needed
  void changeQuality(String quality) {
    selectedQuality.value = quality;
    // If you implement multi-bitrate/HLS, call loadNewSource(...) with the selected rendition.
  }

  // ---------- Settings UI ----------
  void showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.blueGrey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  "Playback Speed",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  "${playbackSpeed.value}x",
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => _showSpeedOptions(context),
              ),
              ListTile(
                title: const Text(
                  "Quality",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  selectedQuality.value,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => _showQualityOptions(context),
              ),
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
      backgroundColor: Colors.blueGrey[900],
      builder: (_) => ListView(
        shrinkWrap: true,
        children: speeds
            .map(
              (s) => Obx(
                () => RadioListTile<double>(
                  value: s,
                  groupValue: playbackSpeed.value,
                  onChanged: (val) async {
                    if (val != null) {
                      Navigator.pop(context);
                      await changePlaybackSpeed(val);
                    }
                  },
                  title: Text(
                    "${s}x",
                    style: const TextStyle(color: Colors.white),
                  ),
                  activeColor: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _showQualityOptions(BuildContext context) {
    final qualities = ["Auto", "1080p", "720p"];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.blueGrey[900],
      builder: (_) => ListView(
        shrinkWrap: true,
        children: qualities
            .map(
              (q) => Obx(
                () => RadioListTile<String>(
                  value: q,
                  groupValue: selectedQuality.value,
                  onChanged: (val) {
                    if (val != null) {
                      Navigator.pop(context);
                      changeQuality(val);
                    }
                  },
                  title: Text(q, style: const TextStyle(color: Colors.white)),
                  activeColor: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ---------- App Lifecycle ----------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!isInitialized.value) return;
    if (state == AppLifecycleState.paused) {
      // Pause when app goes background
      pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  // ---------- Cleanup ----------
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _teardownController();
    _exitFullscreen(); // ensure UI restored
    super.onClose();
  }
}
