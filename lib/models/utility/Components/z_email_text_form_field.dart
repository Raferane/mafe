import 'package:flutter/material.dart';
import 'package:unity_project/controllers/auth_controllers.dart';

class ZEmailTextFormField extends StatelessWidget {
  const ZEmailTextFormField({
    super.key,
    required this.loginEmailController,
    required this.controller,
  });

  final TextEditingController loginEmailController;
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginEmailController,
      onTapOutside: (event) {
        controller.unfocusKeyboard();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xff545454).withAlpha(100)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Color(0xff545454).withAlpha(100),
            width: 2,
          ),
        ),
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xff545454),
          fontSize: 18,
        ),
        hintText: 'Example@gmail.com',
        hintStyle: TextStyle(color: Color(0xff545454).withAlpha(100)),
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
    );
  }
}
