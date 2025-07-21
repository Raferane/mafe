import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Obx(
      () => TextFormField(
        controller: loginPasswordController,
        obscureText: controller.isPasswordVisible.value,
        onTapOutside: (event) {
          controller.unfocusKeyboard();
        },
        keyboardType: TextInputType.visiblePassword,
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
          labelText: 'Password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xff545454),
            fontSize: 18,
          ),
          hintText: '********',
          hintStyle: TextStyle(color: Color(0xff545454).withAlpha(100)),
          suffixIcon: IconButton(
            onPressed: () {
              controller.togglePasswordVisibility();
            },
            icon:
                controller.isPasswordVisible.value == true
                    ? Icon(Icons.visibility_off, color: Color(0xff545454))
                    : Icon(Icons.visibility, color: Color(0xff545454)),
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
      ),
    );
  }
}
