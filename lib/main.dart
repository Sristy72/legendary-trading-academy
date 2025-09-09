import 'package:flutter/material.dart';

import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/others/about_app_screen.dart';
import 'package:flutter_ladydenily/features/others/privacy_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/terms_and_condition_screen.dart';


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
      home: TermsAndConditionScreen()

      //VerifyCodeScreen()

      //Screen()
    );
  }
}