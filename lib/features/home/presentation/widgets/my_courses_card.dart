import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import '../../models/course.dart'; // provides HomeCourse

class MyCoursesCard extends StatelessWidget {
  final HomeCourse course;

  const MyCoursesCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 2)],
      ),
      child: Row(
        children: [
          // Image on the left
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              course.image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          // Description on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${course.lessons} lessons',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColorBlue,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        course.level,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
