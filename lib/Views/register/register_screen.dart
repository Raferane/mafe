import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/Views/Login/components/z_password_text_form_field.dart';
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
  final registerFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerFormKey.currentState?.dispose();
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
        child: Form(
          key: registerFormKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Register',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: registerEmailController,
                    onTapOutside: (event) {
                      controller.unfocusKeyboard();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.green[400],
                        fontSize: 20,
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email field is required";
                      }
                      if (!controller.isValidEmail(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 5,
                  ),
                  child: ZPasswordTextFormField(
                    loginPasswordController: registerPasswordController,
                    controller: controller,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.green[400],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () async {
                    //TODO: Check if the email and password are valid By Firebase and implement the logic
                    if (registerFormKey.currentState!.validate()) {
                      controller.register(
                        registerEmailController.text,
                        registerPasswordController.text,
                      );
                    }
                  },
                  color: Colors.green[500],
                  textColor: Colors.white,
                  minWidth: 300,
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Register', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
