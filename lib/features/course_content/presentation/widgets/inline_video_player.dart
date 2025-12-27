import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../video/presentation/controllers/ video_controller.dart';
import '../../../video/presentation/widgets/video_controls.dart';

class InlineVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isFullScreen;
  final ValueChanged<bool>? onFullScreenToggle;

  const InlineVideoPlayer({
    super.key, 
    required this.videoUrl, 
    this.isFullScreen = false,
    this.onFullScreenToggle,
  });

  @override
  State<InlineVideoPlayer> createState() => _InlineVideoPlayerState();
}

class _InlineVideoPlayerState extends State<InlineVideoPlayer> {
  // YouTube related
  late final WebViewController _youtubeController;
  bool _isYouTubeLoading = true;
  
  // Direct video related
  String? _controllerTag;

  @override
  void initState() {
    super.initState();
    if (_isYouTubeUrl(widget.videoUrl)) {
      _initializeYouTube();
    } else {
      _initializeDirectVideo();
    }
  }

  @override
  void didUpdateWidget(InlineVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      // Cleanup old
      if (_controllerTag != null) {
        Get.delete<VideoPlayerGetxController>(tag: _controllerTag);
        _controllerTag = null;
      }
      
      // Init new
      if (_isYouTubeUrl(widget.videoUrl)) {
        _initializeYouTube();
      } else {
        _initializeDirectVideo();
      }
    }
  }

  @override
  void dispose() {
    if (_controllerTag != null) {
      Get.delete<VideoPlayerGetxController>(tag: _controllerTag);
    }
    super.dispose();
  }

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  void _initializeDirectVideo() {
    _controllerTag = widget.videoUrl;
    final controller = Get.put(VideoPlayerGetxController(widget.videoUrl), tag: _controllerTag);
    
    // Listen to fullscreen changes
    ever(controller.isFullScreen, (bool isFull) {
       widget.onFullScreenToggle?.call(isFull);
    });
  }

  void _initializeYouTube() {
    String embedUrl = _convertToEmbedUrl(widget.videoUrl);
    _youtubeController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isYouTubeLoading = true),
          onPageFinished: (_) => setState(() => _isYouTubeLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(embedUrl));
  }

  String _convertToEmbedUrl(String url) {
    String videoId = '';
    if (url.contains('youtu.be/')) {
      videoId = url.split('youtu.be/')[1].split('?')[0];
    } else if (url.contains('youtube.com/watch?v=')) {
      videoId = url.split('watch?v=')[1].split('&')[0];
    } else if (url.contains('youtube.com/embed/')) {
      return url;
    }
    return 'https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=1';
  }

  @override
  Widget build(BuildContext context) {
    if (_isYouTubeUrl(widget.videoUrl)) {
      return _buildYouTubePlayer();
    } else {
      return _buildDirectPlayer();
    }
  }

  Widget _buildYouTubePlayer() {
    if (widget.isFullScreen) {
      return Stack(
        children: [
          WebViewWidget(controller: _youtubeController),
          if (_isYouTubeLoading)
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      );
    }
    
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          WebViewWidget(controller: _youtubeController),
          if (_isYouTubeLoading)
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildDirectPlayer() {
    final controller = Get.find<VideoPlayerGetxController>(tag: _controllerTag);

    Widget content = Container(
      color: Colors.black,
      child: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        
        final videoCtrl = controller.videoController;
        return Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: videoCtrl.value.aspectRatio > 0 
                  ? videoCtrl.value.aspectRatio 
                  : 16 / 9,
              child: VideoPlayer(videoCtrl),
            ),
            GestureDetector(
              onTap: controller.togglePlayPause,
              child: Obx(() => Icon(
                controller.isPlaying.value
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
                color: Colors.white.withOpacity(0.8),
                size: 50,
              )),
            ),
            VideoControls(controller: controller),
          ],
        );
      }),
    );

    if (widget.isFullScreen) {
      return content;
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: content,
    );
  }
}
