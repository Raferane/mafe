import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Welcome/components/z_sign_up_button.dart';
import 'package:unity_project/Views/register/components/display_name_text_field.dart';
import 'package:unity_project/Views/register/components/z_drop_down_menu.dart';
import 'package:unity_project/models/utility/Components/z_confirm_password_field.dart';
import 'package:unity_project/models/utility/Components/z_email_text_form_field.dart';
import 'package:unity_project/models/utility/Components/z_password_text_form_field.dart';
import 'package:unity_project/controllers/auth_controllers.dart';
import 'package:unity_project/models/utility/Components/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController controller = Get.find<AuthController>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerDisplayNameController = TextEditingController();
  final registerCityController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerDisplayNameController.dispose();
    registerCityController.dispose();
    registerFormKey.currentState?.dispose();
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
            // Register Form
            child: Form(
              key: registerFormKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  // Welcome Text
                  Text(
                    'Welcome to Unity Volunteer',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff545454),
                    ),
                  ),
                  // Register Text
                  Text(
                    'Register a new account',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff545454),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  // Email Text Form Field
                  ZEmailTextFormField(
                    loginEmailController: registerEmailController,
                    controller: controller,
                  ),
                  SizedBox(height: height * 0.04),
                  // Display Name Text Form Field
                  DisplayNameTextField(
                    displayNameController: registerDisplayNameController,
                    controller: controller,
                  ),
                  SizedBox(height: height * 0.04),
                  // Password Text Form Field
                  ZPasswordTextFormField(
                    loginPasswordController: registerPasswordController,
                    controller: controller,
                  ),
                  SizedBox(height: height * 0.04),
                  // Confirm Password Text Form Field
                  ZConfirmPasswordField(
                    confirmPasswordController:
                        registerConfirmPasswordController,
                    controller: controller,
                    registerPasswordController: registerPasswordController,
                  ),
                  SizedBox(height: height * 0.04),
                  // City Drop Down Menu
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ZDropDownMenu(
                      width: width,
                      registerCityController: registerCityController,
                      height: height,
                    ),
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
                  // Sign Up Button
                  ZSignUpButton(
                    text: 'Sign Up',
                    bColor: Color(0xff545454),
                    fColor: Color(0xffedf2f4),
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.045,
                    onPressed: () {
                      if (registerFormKey.currentState!.validate()) {
                        controller.register(
                          registerEmailController.text,
                          registerPasswordController.text,
                          registerCityController.text,
                          registerDisplayNameController.text,
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
