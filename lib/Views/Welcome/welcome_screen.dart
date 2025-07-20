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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/unity_volunteer_logo_noBackground.png',
                  fit: BoxFit.contain,
                  width: width * 0.75,
                ),
                // Text
                Text(
                  'Welcome to Unity Volunteer',
                  style: TextStyle(
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff545454),
                  ),
                ),
                Text(
                  'Unite. Volunteer. Impact.',
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff545454),
                  ),
                ),
                // Button
                SizedBox(height: height * 0.15),
                ZSignInButton(
                  text: 'Sign In',
                  onPressed: () {},
                  bColor: Color(0xff545454),
                  fColor: Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.045,
                  size: Size(width * 0.7, height * 0.05),
                ),
                SizedBox(height: height * 0.02),
                ZSignUpButton(
                  text: 'Sign Up',
                  onPressed: () {},
                  bColor: Color(0xffffffff),
                  fColor: Color(0xff545454),
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  size: Size(width * 0.7, height * 0.05),
                ),
                SizedBox(height: height * 0.04),
                //Deivider
                ZDivider(),
                SizedBox(height: height * 0.04),
                //Google Sign In
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
