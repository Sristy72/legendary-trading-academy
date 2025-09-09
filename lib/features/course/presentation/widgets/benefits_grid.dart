// lib/features/courses/widgets/benefits_grid.dart

import 'package:flutter/material.dart';

class BenefitsGrid extends StatelessWidget {
  final List<String> benefits;

  const BenefitsGrid({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: benefits.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 80,
      ),
      itemBuilder: (ctx, i) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(benefits[0], fit: BoxFit.cover, width: 20),
          const SizedBox(height: 6),
          Text(
            benefits[i],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
