import 'package:flutter/material.dart';


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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(user.image),
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
                          color: Colors.grey,
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
                  ProfileOptionTile(
                    icon: Icons.person,
                    title: "Personal Information",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PersonalInfoScreen())),
                  ),
                  ProfileOptionTile(
                    icon: Icons.lock,
                    title: "Change Password",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ChangePasswordScreen())),
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
