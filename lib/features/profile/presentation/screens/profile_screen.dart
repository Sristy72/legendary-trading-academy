import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/signup_screen.dart';
import 'package:flutter_ladydenily/features/others/about_app_screen.dart';
import 'package:flutter_ladydenily/features/others/privacy_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/refund_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/terms_and_condition_screen.dart';
import 'package:flutter_ladydenily/features/others/video_copyright_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/notification_screen.dart';

import '../../model/profile_model.dart';
import '../widgets/profile_option_tile.dart';
import 'personal_info_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileModel user = ProfileModel(
    name: "Albert Flores",
    location: "New York, NY",
    image: "assets/images/profile.jpg",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Avatar + small overlay icon
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(user.image),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            "assets/icons/avater floating.png",
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.location,
                        style: const TextStyle(
                          color: Color(0xFF4E4E4E),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Profile option list
            Expanded(
              child: ListView(
                children: [
                  //Personal Info..
                  ProfileOptionTile(

                    iconPath: "assets/icons/personal info.png",
                    title: "Personal Information",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PersonalInfoScreen(),
                      ),
                    ),
                  ),
                  //Change pass..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Change Password",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    ),
                  ),
                  //Notification Settings..

                  ProfileOptionTile(
                    iconPath: "assets/icons/notification.png",
                    title: "Notification Settings",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    ),
                  ),

                  //About app..
                  ProfileOptionTile(
                    iconPath: "assets/icons/about app.png",
                    title: "About App",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AboutAppScreen(),
                      ),
                    ),
                  ),

                  //Privacy Policy..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Privacy Policy",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyScreen(),
                      ),
                    ),
                  ),

                  //Term & Condition..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Term & Condition",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TermsAndConditionScreen(),
                      ),
                    ),
                  ),

                  //video copyright..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "video copyright",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VideoCopyrightScreen(),
                      ),
                    ),
                  ),

                  //Refund Policy..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Refund Policy",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RefundPolicyScreen(),
                      ),
                    ),
                  ),


                  //Logout...
                  ProfileOptionTile(
                    iconPath: "assets/icons/logout.png",
                    title: "Logout",
                    iconColor: const Color(0xFFEF1A26),
                    textColor: const Color(0xFFEF1A26),
                    arrowColor: const Color(0xFFEF1A26),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
