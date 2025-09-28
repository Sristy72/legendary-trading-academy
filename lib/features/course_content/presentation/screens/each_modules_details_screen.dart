import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/tab_bar.dart';
import 'package:get/get.dart';
import '../../data/modules/assignment_module.dart';
import '../../data/modules/class_module_module.dart';
import '../../data/modules/resources_model.dart';
import '../../data/modules/video_model.dart';
import '../widgets/module_video_container.dart';
import '../widgets/module_resource_item.dart';
import '../widgets/module_assignment_item.dart';

class EachModulesDetailsScreen extends StatelessWidget {
  EachModulesDetailsScreen({Key? key}) : super(key: key);

  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    // Accept either a Module object or a plain Map (module.toJson())
    final arg = Get.arguments;
    Module? module;
    if (arg is Module) {
      module = arg;
    } else if (arg is Map<String, dynamic>) {
      try {
        module = Module.fromJson(arg);
      } catch (_) {
        module = null;
      }
    } else if (arg is Map) {
      // defensive: sometimes JSON map is dynamic typed
      try {
        module = Module.fromJson(Map<String, dynamic>.from(arg));
      } catch (_) {
        module = null;
      }
    }

    if (module == null) {
      return AppScaffold(
        appBar: AppBar(title: const Text('Module')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No module data provided. Please open a module from the Modules list.',
            ),
          ),
        ),
      );
    }

    final List<VideoItem> recordings = module.video ?? <VideoItem>[];
    final List<ResourceItem> resources = module.resources ?? <ResourceItem>[];
    final List<AssignmentItem> assignments =
        module.assignment ?? <AssignmentItem>[];

    final String topTitle = module.name != null
        ? 'Module - ${module.name}'
        : 'Module';
    final String topDescription =
        module.name ?? 'No description available';

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          topTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Module description (same for all tabs)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              topDescription,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF090F12),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Top count row updates reactively
          Obx(() {
            final idx = _selectedIndex.value;
            String topCountText = '';
            if (idx == 0) {
              topCountText = '${recordings.length} Class Recordings';
            } else if (idx == 1) {
              topCountText = '${resources.length} Resources';
            } else {
              topCountText = '${assignments.length} Assignments';
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/video-recorder.png",
                    width: 18,
                    height: 18,
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
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: recordings.length,
                  itemBuilder: (context, index) {
                    final v = recordings[index];
                    return ModuleVideoContainer(
                      title: v.name ?? 'Recording ${index + 1}',
                      durationText: v.no != null ? 'No: ${v.no}' : '',
                      imagePath: 'assets/images/courses_sample.jpg',
                    );
                  },
                );
              } else if (idx == 1) {
                // Resources
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    final r = resources[index];
                    return ModuleResourceItem(
                      title: r.name ?? 'Resource ${index + 1}',
                      subtitle: r.url ?? '',
                      onTap: () {
                        // implement open resource if needed
                      },
                    );
                  },
                );
              } else {
                // Assignments
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final a = assignments[index];
                    return ModuleAssignmentItem(
                      title: a.title ?? 'Assignment ${index + 1}',
                      dueDate: a.start ?? '',
                      onTap: () {
                        // implement assignment open if needed
                      },
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
