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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 2),
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
    );
  }
}
