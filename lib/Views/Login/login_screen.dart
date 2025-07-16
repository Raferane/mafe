import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/auth_controllers.dart';
import 'package:unity_project/models/utility/Components/loading_overlay.dart';
import 'package:unity_project/models/utility/Components/z_divider.dart';
import 'package:unity_project/Views/Login/components/z_email_text_form_field.dart';
import 'package:unity_project/models/utility/Components/z_submit_button.dart';
import 'package:unity_project/Views/Login/components/z_password_text_form_field.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(elevation: 5, shadowColor: Colors.black),
      body: LoadingOverlay(
        isLoading: controller.isLoading,
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ZEmailTextFormField(
                    loginEmailController: loginEmailController,
                    controller: controller,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ZPasswordTextFormField(
                    loginPasswordController: loginPasswordController,
                    controller: controller,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(102, 187, 106, 1),
                        textStyle: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: () => Get.toNamed('/register'),
                      child: Text('Register Now'),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ZSubmitButton(
                  onPressed: () {
                    //TODO: Check if the email and password are valid By Firebase and implement the logic
                    if (loginFormKey.currentState!.validate()) {
                      controller.login(
                        loginEmailController.text.trim(),
                        loginPasswordController.text,
                      );
                    }
                  },
                  text: 'Login',
                ),
                SizedBox(height: 30),
                ZDivider(),
                //TODO: Add the button for google login and add a guest Login Button.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
