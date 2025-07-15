import 'package:flutter/material.dart';
import 'package:unity_project/controllers/auth_controllers.dart';

class ZPasswordTextFormField extends StatelessWidget {
  const ZPasswordTextFormField({
    super.key,
    required this.loginPasswordController,
    required this.controller,
  });

  final TextEditingController loginPasswordController;
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginPasswordController,
      obscureText: controller.isPasswordVisible,
      onTapOutside: (event) {
        controller.unfocusKeyboard();
      },
      keyboardType: TextInputType.visiblePassword,
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
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.green[400],
          fontSize: 20,
        ),
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: IconButton(
          onPressed: () {
            controller.togglePasswordVisibility();
          },
          icon:
              controller.isPasswordVisible == true
                  ? Icon(Icons.visibility_off, color: Colors.green[400])
                  : Icon(Icons.visibility, color: Colors.green[400]),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password field is required";
        }
        if (!controller.isValidPassword(value)) {
          return "Password must be at least 6 characters long";
        }
        return null;
      },
    );
  }
}
