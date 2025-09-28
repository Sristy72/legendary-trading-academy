import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_screen.dart';
import 'package:get/get.dart';
import '../../models/course.dart';

class CourseDetailsCard extends StatelessWidget {
  final Course course;

  const CourseDetailsCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const CourseDetailsScreen(), arguments: course);
      },
      child: Card(
        color: AppColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      ),
    );
  }

  Widget _buildImageWithBadge() {
    final imageUrl = course.photo?.url;
    final hasNetworkImage = imageUrl != null && imageUrl.isNotEmpty;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: hasNetworkImage
              ? Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildFallbackImage(),
                )
              : _buildFallbackImage(),
        ),
        Positioned(top: 12, left: 12, child: _Badge(text: "Freshman")),
      ],
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      height: 180,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }

  Widget _buildCourseTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        course.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        course.description,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 97, 97, 97),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCourseMetadata() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _MetadataItem(
            icon: Icons.folder_open_outlined,
            text: '${course.modules.length} Modules',
          ),
          const SizedBox(width: 12),
          _MetadataItem(
            icon: Icons.play_circle_outline,
            text:
                '${course.modules.fold(0, (prev, module) => prev + module.video.length)} Videos',
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${course.price}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.textColorBlue,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => ModuleScreen(courseId: course.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow.shade700,
              foregroundColor: AppColors.textColorBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Enroll Now'),
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
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textColorBlue, fontSize: 12),
      ),
    );
  }
}

class _MetadataItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetadataItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
}
