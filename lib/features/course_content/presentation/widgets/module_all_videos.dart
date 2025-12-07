import 'package:flutter/material.dart';
import '../../data/models/class_module_module.dart';
import '../../data/models/module_video_container.dart';

class ModuleAllVideos extends StatelessWidget {
  final int index;
  final Module module; // Accept module data
  final Function(String url, String title, String date)? onVideoTap;

  const ModuleAllVideos({
    super.key, 
    required this.index, 
    required this.module,
    this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE8ECF1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 2, left: 12),
            child: Text("Module ${index + 1}", textAlign: TextAlign.start),
          ),
          Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView.builder(
              itemBuilder: (context, videoIndex) {
                final video = module.video[videoIndex];
                debugPrint('Building video $videoIndex: name=${video.name}, url=${video.url}');
                return ModuleVideoContainer(
                  title: video.name ?? 'Video ${videoIndex + 1}',
                  durationText: 'Video ${videoIndex + 1}', // TODO: Fix date/duration
                  imagePath: 'assets/images/courses_sample.jpg',
                  videoUrl: video.url,
                  onTap: () {
                     if (onVideoTap != null && video.url != null) {
                        onVideoTap!(video.url!, video.name ?? 'Video', 'Video ${videoIndex + 1}');
                     }
                  },
                );
              },
              itemCount: module.video.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
