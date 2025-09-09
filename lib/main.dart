import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/home/presentation/screens/home_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() {
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
      home: LoginScreen(),
    );
  }
}
