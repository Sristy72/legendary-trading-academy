import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../video/presentation/screens/video_player_screen.dart';
import '../../../video/presentation/screens/youtube_player_screen.dart';

class ModuleVideoContainer extends StatelessWidget {
  final String title;
  final String durationText;
  final String imagePath;
  final String? videoUrl;

  const ModuleVideoContainer({
    super.key,
    this.title = 'Course Name',
    this.durationText = '24 May 2025 | 2h 30m 33s',
    this.imagePath = 'assets/images/courses_sample.jpg',
    this.videoUrl,
  });

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('ModuleVideoContainer tapped - Title: $title, VideoUrl: $videoUrl');
        if (videoUrl != null && videoUrl!.isNotEmpty) {
          if (_isYouTubeUrl(videoUrl!)) {
            debugPrint('YouTube URL detected, navigating to YouTubePlayerScreen');
            Get.to(() => YouTubePlayerScreen(youtubeUrl: videoUrl!));
          } else {
            debugPrint('Direct video URL, navigating to VideoPlayerScreen');
            Get.to(() => VideoPlayerScreen(videoUrl: videoUrl!));
          }
        } else {
          debugPrint('VideoUrl is null or empty, cannot play video');
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 12),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF4F4F4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    height: 50,
                    width: 72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1, // Limit to 1 line
                      overflow:
                          TextOverflow.ellipsis, // Add ellipses for overflow
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff090F12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      durationText,
                      maxLines: 1, // Limit to 1 line
                      overflow:
                          TextOverflow.ellipsis, // Add ellipses for overflow
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4E4E4E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
