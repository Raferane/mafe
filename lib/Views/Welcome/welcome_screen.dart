import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Welcome/components/z_google_sign_in_button.dart';
import 'package:unity_project/Views/Welcome/components/z_guest_text_button.dart';
import 'package:unity_project/Views/Welcome/components/z_sign_in_button.dart';
import 'package:unity_project/Views/Welcome/components/z_sign_up_button.dart';
import 'package:unity_project/controllers/auth_controllers.dart';
import 'package:unity_project/models/utility/Components/z_divider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Color(0xffedf2f4),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
                  Image.asset(
                    'assets/unity_volunteer_logo_noBackground.png',
                    fit: BoxFit.contain,
                    width: width * 0.3,
                    height: height * 0.1,
                  ),
                  SizedBox(height: height * 0.02),
                  // Welcome Text
                  Text(
                    'Welcome to Unity Volunteer',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff545454),
                    ),
                  ),
                  // Slogan
                  Text(
                    'Unite. Volunteer. Impact.',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff545454),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  // Sign In Button
                  ZSignInButton(
                    text: 'Sign In',
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    bColor: Color(0xff545454),
                    fColor: Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.045,
                    size: Size(width * 0.7, height * 0.05),
                  ),
                  SizedBox(height: height * 0.02),
                  // Sign Up Button
                  ZSignUpButton(
                    text: 'Sign Up',
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    bColor: Color(0xffffffff),
                    fColor: Color(0xff545454),
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w500,
                    size: Size(width * 0.7, height * 0.05),
                  ),
                  SizedBox(height: height * 0.04),
                  // Divider
                  ZDivider(),
                  SizedBox(height: height * 0.04),
                  // Google Sign In
                  ZGoogleSignInButton(
                    text: 'Google',
                    onPressed: () {
                      controller.signInWithGoogle();
                    },
                    bColor: Color(0xff545454).withAlpha(170),
                    fColor: Color(0xffffffff),
                    size: Size(width * 0.7, height * 0.05),
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: height * 0.02),
                  // Guest Text Button
                  ZGuestTextButton(
                    text: "Continue as a guest",
                    onPressed: () {
                      controller.signInAnonymously();
                    },
                    fColor: Color(0xff545454).withAlpha(170),
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                    textDecoration: TextDecoration.underline,
                  ),
                  SizedBox(height: height * 0.02),
                  // Version Text
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff545454).withAlpha(60),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
