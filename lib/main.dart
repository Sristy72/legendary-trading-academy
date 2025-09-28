import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/init/app_initializer.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/splash_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/each_modules_details_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/recording_details_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/resources_details_screen.dart';
import 'package:get/get.dart';

import 'features/course_content/presentation/screens/upload_assignment_screen.dart';

void main() async {
  await AppInitializer.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
