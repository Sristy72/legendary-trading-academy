import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/demo/screen.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/upload_profile_screen.dart';

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
      home: UploadProfileScreen(),
    );
  }
}
