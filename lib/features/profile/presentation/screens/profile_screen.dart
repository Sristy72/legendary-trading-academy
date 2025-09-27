import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/others/about_app_screen.dart';
import 'package:flutter_ladydenily/features/others/privacy_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/refund_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/terms_and_condition_screen.dart';
import 'package:flutter_ladydenily/features/others/video_copyright_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/change_password_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/notification_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/personal_info_screen.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Handle loading
          if (_profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }


          final userInfo = _profileController.userInfo.value;

          // Handle empty data
          if (userInfo == null) {
            return const Center(
              child: Text(
                "No profile data found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // Extract avatar safely
          final avatarUrl = userInfo.avatar.url;

          return Column(
            children: [
              const SizedBox(height: 8),

              // ===== Profile Header =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: avatarUrl.isNotEmpty
                              ? NetworkImage(avatarUrl)
                              : const AssetImage(
                            'assets/images/avatar_placeholder.png',
                          ) as ImageProvider,
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

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     children: [
            //       // Avatar + small overlay icon
            //       Stack(
            //         children: [
            //           CircleAvatar(
            //             radius: 40,
            //             backgroundImage: AssetImage(user.image),
            //           ),
            //           Positioned(
            //             bottom: 0,
            //             right: 0,
            //             child: Container(
            //               decoration: const BoxDecoration(
            //                 color: Color(0xFFEFC227),
            //                 shape: BoxShape.circle,
            //               ),
            //               padding: const EdgeInsets.all(4),
            //               child: Image.asset(
            //                 "assets/icons/avater floating.png",
            //                 width: 16,
            //                 height: 16,
            //               ),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(width: 16),
            //
            //         // ===== User Info =====
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               userInfo.name ?? "No Name",
            //               style: const TextStyle(
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             const SizedBox(height: 4),
            //             Text(
            //               userInfo.address ?? "Unknown Location",
            //               style: const TextStyle(
            //                 color: Color(0xFF4E4E4E),
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),

              // const SizedBox(height: 20),

              // ===== Options List =====
              Expanded(
                child: ListView(
                  children: [
                    ProfileOptionTile(
                      iconPath: "assets/icons/personal info.png",
                      title: "Personal Information",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalInfoScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Change Password",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/notification.png",
                      title: "Notification Settings",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/about app.png",
                      title: "About App",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutAppScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Privacy Policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Term & Condition",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const TermsAndConditionScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Video Copyright",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VideoCopyrightScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Refund Policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RefundPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/logout.png",
                      title: "Logout",
                      iconColor: const Color(0xFFEF1A26),
                      textColor: const Color(0xFFEF1A26),
                      arrowColor: const Color(0xFFEF1A26),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
            // Profile option list
            Expanded(
              child: ListView(
                children: [
                  //Personal Info..
                  ProfileOptionTile(
                    iconPath: "assets/icons/personal info.png",
                    title: "Personal Information",
                    onTap: () {
                      Get.to(() => const PersonalInfoScreen());
                    },
                  ),
                  //Change pass..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Change Password",
                    onTap: () {
                      Get.to(() => const ChangePasswordScreen());
                    },
                  ),

                  //Notification Settings..
                  ProfileOptionTile(
                    iconPath: "assets/icons/notification.png",
                    title: "Notification Settings",
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                  ),

                  //About app..
                  ProfileOptionTile(
                    iconPath: "assets/icons/about app.png",
                    title: "About App",

                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const AboutAppScreen(),
                    //   ),
                    // ),
                    onTap: () {
                      Get.to(() => const AboutAppScreen());
                    },
                  ),

                  //Privacy Policy..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Privacy Policy",
                    onTap: () {
                      Get.to(() => const PrivacyPolicyScreen());
                    },
                  ),

                  //Term & Condition..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Term & Condition",
                    onTap: () {
                      Get.to(() => const TermsAndConditionScreen());
                    },
                  ),

                  //video copyright..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "video copyright",
                    onTap: () {
                      Get.to(() => const VideoCopyrightScreen());
                    },
                  ),

                  //Refund Policy..
                  ProfileOptionTile(
                    iconPath: "assets/icons/change pass.png",
                    title: "Refund Policy",
                    onTap: () {
                      Get.to(() => const RefundPolicyScreen());
                    },
                  ),

                  //Logout...
                  ProfileOptionTile(
                    iconPath: "assets/icons/logout.png",
                    title: "Logout",
                    iconColor: const Color(0xFFEF1A26),
                    textColor: const Color(0xFFEF1A26),
                    arrowColor: const Color(0xFFEF1A26),
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
