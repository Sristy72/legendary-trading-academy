import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/demo/screen.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/upload_profile_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/course_all_screen.dart';
import 'package:flutter_ladydenily/features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: CourseDetailsScreen(),
    );
  }
}
