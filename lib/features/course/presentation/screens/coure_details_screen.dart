// lib/features/courses/screens/course_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/dummy_data.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/benefits_grid.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/course_header.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/demo_card.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/enroll_button.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/trainer_card.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = dummyCoursesDetails;

    return Scaffold(
      appBar: AppBar(
        title: Text(courses[0].title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseHeader(course: courses[0]),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CourseDemoCard(
                      image: courses[0].image,
                      onTap: () {
                        print("Play demo video");
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Trainer",
              style: TextStyle(
                color: AppColors.textColorBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TrainerCard(
              name: courses[0].trainerName,
              image: courses[0].trainerImage,
              stats: courses[0].trainerStats,
            ),
            const SizedBox(height: 16),
            const Text(
              "You will get",
              style: TextStyle(
                color: AppColors.textColorBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            BenefitsGrid(
              benefitsImages: courses[0].benefitImages,
              benefits: courses[0].benefits,
            ),
          ],
        ),
      ),
      bottomNavigationBar: EnrollButton(
        price: 120,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enrolled Successfully!")),
          );
        },
      ),
    );
  }
}
