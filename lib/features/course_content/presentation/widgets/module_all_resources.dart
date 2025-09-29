import 'package:flutter/material.dart';
import '../../data/modles/class_module_module.dart';

class ModuleAllResources extends StatelessWidget {
  final Module module;
  final int index; // Add index parameter if needed

  const ModuleAllResources({
    super.key,
    required this.module,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Module ${index + 1}:', // Use index here if needed
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: module.resources.length,
              itemBuilder: (context, resourceIndex) {
                final resource = module.resources[resourceIndex];
                return ListTile(
                  leading: const Icon(Icons.file_present),
                  title: Text(resource.name ?? 'Resource ${resourceIndex + 1}'),
                  subtitle: Text(resource.name ?? 'No description'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
