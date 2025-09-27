import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/tab_bar.dart';
import 'package:get/get.dart';

import '../widgets/module_video_container.dart';
import '../widgets/module_resource_item.dart';
import '../widgets/module_assignment_item.dart';

class EachModulesDetailsScreen extends StatelessWidget {
  EachModulesDetailsScreen({Key? key}) : super(key: key);

  // Use GetX reactive variable for selected tab index
  final RxInt _selectedIndex = 0.obs;

  // Example lists; replace with real data when wiring to API
  final List<int> _recordings = List.generate(9, (i) => i + 1);
  final List<int> _resources = List.generate(5, (i) => i + 1);
  final List<int> _assignments = List.generate(3, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    const String topTitle = 'Module -1';
    const String topDescription =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          topTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Module description (same for all tabs in this simplified view)
          const Text(
            topDescription,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF090F12),
            ),
          ),
          const SizedBox(height: 12),

          // Top count row updates reactively
          Obx(() {
            final idx = _selectedIndex.value;
            String topCountText = '';
            if (idx == 0) {
              topCountText = '${_recordings.length} Class Recordings';
            } else if (idx == 1) {
              topCountText = '${_resources.length} Resources';
            } else {
              topCountText = '${_assignments.length} Assignments';
            }
            return Row(
              children: [
                Container(
                  child: Image(
                    image: AssetImage("assets/icons/video-recorder.png"),
                    width: 18,
                    height: 18,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  topCountText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4E4E4E),
                  ),
                ),
              ],
            );
          }),

          // ModuleTabBar with reactive selectedIndex
          Obx(
            () => ModuleTabBar(
              selectedIndex: _selectedIndex.value,
              onTabChanged: (index) => _selectedIndex.value = index,
            ),
          ),

          const SizedBox(height: 12),

          // Expanded list that swaps content based on selected tab reactively
          Expanded(
            child: Obx(() {
              final idx = _selectedIndex.value;
              if (idx == 0) {
                // Recordings
                return ListView.builder(
                  // padding: const EdgeInsets.all(8),
                  itemCount: _recordings.length,
                  itemBuilder: (context, index) => ModuleVideoContainer(
                    title: 'Recording ${index + 1}',
                    durationText: '24 May 2025 | 2h ${10 + index}m',
                    imagePath: 'assets/images/courses_sample.jpg',
                  ),
                );
              } else if (idx == 1) {
                // Resources
                return ListView.builder(
                  // padding: const EdgeInsets.all(8),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ModuleResourceItem(
                      title: 'Resource ${index + 1}',
                      subtitle: 'PDF • ${(index + 1) * 2} MB',
                      onTap: () {},
                    );
                  },
                );
              } else {
                // Assignments
                return ListView.builder(
                  // padding: const EdgeInsets.all(8),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ModuleAssignmentItem(
                      title: 'Assignment ${index + 1}',
                      dueDate: 'Due: ${30 + index} Sep 2025',
                      onTap: () {},
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
