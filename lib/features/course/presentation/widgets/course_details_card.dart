import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_screen.dart';
import 'package:get/get.dart';
import '../../models/course_details.dart';

class CourseDetailsCard extends StatelessWidget {
  final CourseDetails courseDetails;

  const CourseDetailsCard({super.key, required this.courseDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course image with badge
          _buildImageWithBadge(),
          const SizedBox(height: 8),
          _buildCourseTitle(),
          const SizedBox(height: 4),
          _buildCourseSubtitle(),
          const SizedBox(height: 8),
          _buildCourseMetadata(),
          const SizedBox(height: 12),
          _buildPriceAndButton(),
        ],
      ),
    );
  }

  Widget _buildImageWithBadge() {
    return Stack(
      children: [
        // Course image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Image.asset(
            courseDetails.image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // Badge positioned on top left
        Positioned(top: 12, left: 12, child: _Badge(text: "Freshman")),
      ],
    );
  }

  Widget _buildCourseTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        courseDetails.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        courseDetails.subtitle,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _buildCourseMetadata() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(courseDetails.weeks, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(width: 16),
          Icon(Icons.menu_book, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            courseDetails.modules,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            courseDetails.price.isEmpty ? "" : courseDetails.price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              /// [Note : Need to modifye this part]
              Get.to(ModuleScreen());
            },
            child: Text(courseDetails.status),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
