// lib/features/courses/widgets/trainer_card.dart

import 'package:flutter/material.dart';

class TrainerCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String stats;

  const TrainerCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(stats),
      ),
    );
  }
}
