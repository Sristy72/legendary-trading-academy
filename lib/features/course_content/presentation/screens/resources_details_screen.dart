import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/module_all_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Resources",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ModuleAllResources(index: index);
        },
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
      ),
    );
    ;
  }
}
