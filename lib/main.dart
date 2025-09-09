import 'package:flutter/material.dart';

import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:get/get.dart';

// Importing all the profile screens
import 'features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/model/profile_model.dart';
import 'features/profile/presentation/screens/personal_info_screen.dart';
import 'features/profile/presentation/screens/change_password_screen.dart';


/*import 'features/profile/presentation/screens/notification_screen.dart';
import 'features/profile/presentation/screens/about_screen.dart';
import 'features/profile/presentation/screens/privacy_policy_screen.dart';
import 'features/profile/presentation/screens/terms_screen.dart';
import 'features/profile/presentation/screens/video_copyright_screen.dart';
import 'features/profile/presentation/screens/refund_policy_screen.dart';
*/
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
