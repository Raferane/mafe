import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/services/app_service.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Get.find<AppService>();
    // Use a FutureBuilder to check auth state and delay the splash screen
    return FutureBuilder(
      future: Future.delayed(
        Duration(milliseconds: 2000), // Increased time for better splash effect
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildSplashScreen();
        }
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // User is logged in, restore user and navigate to home
          appService.restoreUser();
          Future.microtask(() => Get.offAllNamed('/home'));
        } else {
          // User is not logged in, navigate to welcome
          Future.microtask(() => Get.offAllNamed('/welcome'));
        }
        // Return splash screen while navigation is happening
        return _buildSplashScreen();
      },
    );
  }

  Widget _buildSplashScreen() {
    return Scaffold(
      backgroundColor: Color(0xffedf2f4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Unity Volunteer Logo
            Container(
              width: 120,
              height: 120,
              child: Image.asset(
                'assets/unity_volunteer_logo_noBackground.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40),
            // Unity Volunteer Name
            Text(
              "Unity Volunteer",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 8),
            // Unity Volunteer Slogan
            Text(
              "Unite. Volunteer. Impact.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff545454).withAlpha(100),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 60),
            // Loading Spinner
            CircularProgressIndicator(color: Color(0xff545454), strokeWidth: 3),
            SizedBox(height: 20),
            // Loading Text
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff545454).withAlpha(80),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
