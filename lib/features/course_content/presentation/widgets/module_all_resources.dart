import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/module_resource_item.dart';

import 'module_video_container.dart';

class ModuleAllResources extends StatelessWidget {
  final int index;
  const ModuleAllResources({super.key, required this.index});

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
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ModuleResourceItem(
                  title: 'Resource ${index + 1}',
                  subtitle: 'Description for resource ${index + 1}',
                );
              },
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
