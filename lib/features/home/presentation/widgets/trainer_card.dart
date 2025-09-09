import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import '../../models/trainer.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth, // Full width
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(trainer.image)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, 
              children: [
                Text(
                  trainer.name, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                    )
                  ),
                const SizedBox(height: 4),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ", 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 12
                    )
                  ),
                  const SizedBox(height: 4),
                Row(
                  children: [
                    Text('${trainer.courses} Courses', style: const TextStyle(fontSize: 14, color: AppColors.textColorBlue)),
                    const Spacer(),
                    const Text('Success Rate: 100%', style: TextStyle(fontSize: 14, color: AppColors.textColorBlue)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
