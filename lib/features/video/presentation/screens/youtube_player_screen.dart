import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String youtubeUrl;
  
  const YouTubePlayerScreen({super.key, required this.youtubeUrl});

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    // Convert YouTube URL to embed format
    String embedUrl = _convertToEmbedUrl(widget.youtubeUrl);
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(embedUrl));
  }

  String _convertToEmbedUrl(String url) {
    // Handle various YouTube URL formats
    String videoId = '';
    
    if (url.contains('youtu.be/')) {
      // Format: https://youtu.be/VIDEO_ID
      videoId = url.split('youtu.be/')[1].split('?')[0];
    } else if (url.contains('youtube.com/watch?v=')) {
      // Format: https://www.youtube.com/watch?v=VIDEO_ID
      videoId = url.split('watch?v=')[1].split('&')[0];
    } else if (url.contains('youtube.com/embed/')) {
      // Already in embed format
      return url;
    }
    
    // Return embed URL
    return 'https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('YouTube Video'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
