// lib/features/courses/screens/course_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/dummy_data.dart';
import '../widgets/course_header.dart';
import '../widgets/trainer_card.dart';
import '../widgets/benefits_grid.dart';
import '../widgets/enroll_button.dart';
import '../widgets/demo_card.dart';

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
                      imageUrl: "https://dummyimage.com/600x300/000/fff&text=Course+Demo",
                      onTap: () {
                        // Handle play button tap
                        print("Play demo video");
                      },
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            const Text("Trainer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TrainerCard(
              name: courses[0].trainerName,
              imageUrl: courses[0].trainerImage,
              stats: courses[0].trainerStats,
            ),
            const SizedBox(height: 16),
            const Text("You will get",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            BenefitsGrid(benefits: courses[0].benefits),
          ],
        ),
      ),
      bottomNavigationBar: EnrollButton(
        price: 99,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enrolled Successfully!")),
          );
        },
      ),
    );
  }
}
