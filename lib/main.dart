import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/others/legendary_book_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/marketplace_screen.dart';

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
