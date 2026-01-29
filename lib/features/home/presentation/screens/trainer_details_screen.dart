import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/home/models/trainer_api_model.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/course_enroll_card.dart';
import 'package:get/get.dart';

class TrainerDetailsScreen extends StatelessWidget {
  final TrainerApiModel trainer;

  const TrainerDetailsScreen({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    // We can use CourseController to find courses by this trainer
    // Assuming 'coordinator' in Course matches trainer ID or we filter by checking list
    final courseController = Get.find<CourseController>();
    
    // Filter courses where this trainer is a coordinator
    // Note: trainer.id should match coordinator user id
    final trainerCourses = courseController.courses.where((course) {
      return course.coordinator.any((coordinator) => coordinator.id == trainer.id);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {
              // Edit action placeholder
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section (Profile)
            Container(
              color: Colors.transparent, 
              // Using a stack or column to lay it out. User provided image shows simple clean layout.
              // Let's mimic the style.
              padding: const EdgeInsets.only(top: 100, bottom: 20, left: 16, right: 16),
              child: Center(
                child: Column(
                  children: [
                    // Avatar/Image
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: trainer.displayAvatarUrl.isNotEmpty
                            ? Image.network(
                                trainer.displayAvatarUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/avatar.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Rating Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B8C9E), // Teal/Slate color from image
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.black, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            trainer.overallRating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.black, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name
                    Text(
                      trainer.displayName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.titleTextColor,
                      ),
                    ),
                    
                    // Role
                    Text(
                      trainer.role.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    // Location/Description (Mocking serving area as per image if not in model)
                    const Text(
                       // If we don't have location, use generic or description
                      "Serving Online & Global Areas", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Courses Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8ECF1), // Grey background for list
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '${trainerCourses.length} Courses',
                     style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (trainerCourses.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text("No courses available for this trainer"),
                      ),
                    )
                  else
                    ...trainerCourses.map((course) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CourseEnrollCard(course: course),
                    )),
                    
                   // Add extra padding at bottom
                   const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
