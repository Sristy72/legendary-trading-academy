/// Utility class for handling various video URL formats
class VideoUrlHelper {
  /// Detects if a URL is a YouTube URL
  static bool isYouTubeUrl(String url) {
    return url.contains('youtube.com') ||
        url.contains('youtu.be') ||
        url.contains('m.youtube.com');
  }

  /// Extracts YouTube video ID from various YouTube URL formats
  /// Supports:
  /// - https://www.youtube.com/watch?v=VIDEO_ID
  /// - https://youtu.be/VIDEO_ID
  /// - https://www.youtube.com/embed/VIDEO_ID
  static String? extractYouTubeVideoId(String url) {
    try {
      // Standard YouTube URL
      if (url.contains('watch?v=')) {
        final uri = Uri.parse(url);
        return uri.queryParameters['v'];
      }
      // Shortened YouTube URL
      if (url.contains('youtu.be/')) {
        final videoId = url.split('youtu.be/').last.split('?').first;
        return videoId.isNotEmpty ? videoId : null;
      }
      // Embed URL
      if (url.contains('/embed/')) {
        final videoId = url.split('/embed/').last.split('?').first;
        return videoId.isNotEmpty ? videoId : null;
      }
    } catch (e) {
      print('Error extracting YouTube video ID: $e');
    }
    return null;
  }

  /// Converts a YouTube video ID to an HLS stream URL (using yt-dlp or similar service)
  /// Note: This requires a backend service or an external API that converts YouTube URLs
  /// For now, we return a placeholder that indicates the URL type
  static String? convertYouTubeToStream(String videoId) {
    // You would need to use a service like:
    // 1. YouTube's official API (requires API key and authentication)
    // 2. yt-dlp API (if you have a backend)
    // 3. pytube or similar service
    // 4. InvidiousAPI or similar proxy service

    // For now, return null to indicate YouTube URLs need special handling
    // In a production app, you'd need to implement backend support
    return null;
  }

  /// Detects if a URL is a valid direct video URL (mp4, m3u8, etc.)
  static bool isDirectVideoUrl(String url) {
    final path = url.toLowerCase();
    return path.endsWith('.mp4') ||
        path.endsWith('.m3u8') ||
        path.endsWith('.webm') ||
        path.endsWith('.mkv') ||
        path.endsWith('.flv') ||
        path.contains('.mp4?') ||
        path.contains('.m3u8?') ||
        path.contains('streaming') || // Common CDN pattern
        path.contains('video') || // Common CDN pattern
        path.contains('blob:'); // Blob URL
  }

  /// Validates and processes a video URL
  /// Returns the URL to use, or null if the URL cannot be played directly
  static String? processVideoUrl(String url) {
    if (url.isEmpty) return null;

    // Check if it's a YouTube URL
    if (isYouTubeUrl(url)) {
      final videoId = extractYouTubeVideoId(url);
      if (videoId != null) {
        // Return a URL that indicates this is YouTube (for special handling in controller)
        return 'youtube:$videoId';
      }
      return null;
    }

    // Check if it's a direct video URL
    if (isDirectVideoUrl(url)) {
      return url;
    }

    // Assume it's a streaming URL (HLS, DASH, etc.)
    if (url.startsWith('http')) {
      return url;
    }

    return null;
  }

  /// Gets a display name for the video type
  static String getVideoTypeName(String url) {
    if (isYouTubeUrl(url)) {
      return 'YouTube';
    }
    if (url.contains('.m3u8')) {
      return 'HLS Stream';
    }
    if (url.contains('.mp4')) {
      return 'MP4 Video';
    }
    if (url.startsWith('blob:')) {
      return 'Local Video';
    }
    return 'Video';
  }
}
