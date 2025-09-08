import 'package:flutter/material.dart';

import 'package:flutter_ladydenily/core/theme/app_theme.dart';


import 'features/auth/presentation/screen/create_new_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: CreateNewPasswordScreen()

      //VerifyCodeScreen()

      //Screen()
    );
  }
}