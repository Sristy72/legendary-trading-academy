import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/module_all_videos.dart';

class RecordingDetailsScreen extends StatelessWidget {
  const RecordingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Recordings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ModuleAllVideos(index: index);
        },
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}