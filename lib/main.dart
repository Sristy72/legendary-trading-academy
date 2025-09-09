import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Profile'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ),
    );
  }
}
