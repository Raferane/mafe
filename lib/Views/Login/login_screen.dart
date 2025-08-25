import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Welcome/components/z_sign_in_button.dart';
import 'package:unity_project/controllers/auth_controllers.dart';
import 'package:unity_project/models/utility/Components/loading_overlay.dart';
import 'package:unity_project/models/utility/Components/z_email_text_form_field.dart';
import 'package:unity_project/models/utility/Components/z_password_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.find<AuthController>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      // Loading overlay
      body: LoadingOverlay(
        isLoading: controller.isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            // Login Form
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  // Welcome Back Text
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff545454),
                    ),
                  ),
                  // Login Text
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff545454),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  // Email Text Form Field
                  ZEmailTextFormField(
                    loginEmailController: loginEmailController,
                    controller: controller,
                  ),
                  SizedBox(height: height * 0.04),
                  // Password Text Form Field
                  ZPasswordTextFormField(
                    loginPasswordController: loginPasswordController,
                    controller: controller,
                  ),
                  SizedBox(height: height * 0.01),
                  // Remember Me Checkbox, not working for now. Just used for UI
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          activeColor: Color(0xff545454),
                          checkColor: Color(0xffedf2f4),
                          side: BorderSide(
                            color: Color(0xff545454).withAlpha(100),
                          ),
                          value: controller.isRememberMe.value,
                          onChanged: (value) {
                            controller.isRememberMe.value = value ?? false;
                          },
                        ),
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff545454),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  // Sign In Button
                  ZSignInButton(
                    text: 'Sign In',
                    bColor: Color(0xff545454),
                    fColor: Color(0xffedf2f4),
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.045,
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        controller.login(
                          loginEmailController.text,
                          loginPasswordController.text,
                        );
                      }
                    },
                    size: Size(width * 0.7, height * 0.05),
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
