import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_screen.dart';
import 'package:get/get.dart';
import '../../models/course_details.dart';
import '../../models/api_course.dart';

class CourseDetailsCard extends StatelessWidget {
  final CourseDetails? courseDetails; // legacy dummy model
  final ApiCourse? apiCourse; // API model

  const CourseDetailsCard({super.key, this.courseDetails, this.apiCourse})
    : assert(
        courseDetails != null || apiCourse != null,
        'Provide either courseDetails or apiCourse',
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(CourseDetailsScreen());
      },
      child: Card(
        color: AppColors.cardBackgroundColor,
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
            _image,
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
        _title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCourseSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        _subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 97, 97, 97),
        ),
      ),
    );
  }

  Widget _buildCourseMetadata() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(_weeks, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 16),
          Icon(Icons.menu_book, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(_modulesLabel, style: TextStyle(color: Colors.grey[700])),
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
            _price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.textColorBlue,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow.shade700,
              foregroundColor: AppColors.textColorBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              /// [Note : Need to modifye this part]
              Get.to(ModuleScreen());
            },
            child: Text(_statusLabel),
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

extension on CourseDetailsCard {
  String get _title => apiCourse?.name ?? courseDetails!.title;
  String get _subtitle {
    if (apiCourse != null) {
      final desc = apiCourse!.description;
      return desc.length > 60 ? desc.substring(0, 57) + '...' : desc;
    }
    return courseDetails!.subtitle;
  }

  String get _weeks =>
      courseDetails?.weeks ?? '${apiCourse!.modules.length} Modules';
  String get _modulesLabel =>
      courseDetails?.modules ?? '${apiCourse!.modules.length} Mods';
  String get _price => apiCourse != null
      ? '\$${apiCourse!.offerPrice != 0 ? apiCourse!.offerPrice : apiCourse!.price}'
      : (courseDetails!.price.isEmpty ? '' : courseDetails!.price);
  String get _statusLabel => courseDetails?.status ?? 'Enroll Now';
  String get _image {
    if (apiCourse != null) {
      final url = apiCourse!.photo?.url;
      if (url != null && url.isNotEmpty) {
        return url; // For now using Image.network not implemented here
      }
      return 'assets/images/courses_sample.jpg';
    }
    return courseDetails!.image;
  }
}
