import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import '../../../course/models/course.dart';

class MyCourseCard extends StatelessWidget {
  final Course course;

  const MyCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 2)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: (() {
              final imageUrl = course.photo == null
                  ? ''
                  : course.photo is String
                  ? course.photo as String
                  : (course.photo as dynamic).url ?? '';
              if (imageUrl.isEmpty) {
                return SizedBox(
                  width: 120,
                  height: 96,
                  child: Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              if (imageUrl.startsWith('http')) {
                return Image.network(
                  imageUrl,
                  width: 120,
                  height: 96,
                  fit: BoxFit.cover,
                );
              }
              return Image.asset(
                imageUrl,
                width: 120,
                height: 96,
                fit: BoxFit.cover,
              );
            }()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${course.modules.length} Lessons',
                    style: const TextStyle(fontSize: 12),
                  ),

                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // Price text should be flexible and ellipsize if needed
                      Flexible(
                        child: Text(
                          // offerPrice is numeric in the model; format safely
                          (() {
                            try {
                              final val = course.offerPrice.toDouble();
                              return val == 0.0
                                  ? 'Free'
                                  : '\$${val.toStringAsFixed(2)}';
                            } catch (_) {
                              return course.offerPrice.toString();
                            }
                          })(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textColorBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Spacer(),

                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 72,
                          maxWidth: 110,
                        ),

                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow.shade700,
                              foregroundColor: AppColors.textColorBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const FittedBox(child: Text("Resume")),
                          ),
                        ),
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
