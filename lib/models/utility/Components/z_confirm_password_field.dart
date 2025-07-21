import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/auth_controllers.dart';

class ZConfirmPasswordField extends StatelessWidget {
  const ZConfirmPasswordField({
    super.key,
    required this.confirmPasswordController,
    required this.controller,
    required this.registerPasswordController,
  });

  final TextEditingController confirmPasswordController;
  final AuthController controller;
  final TextEditingController registerPasswordController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: confirmPasswordController,
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
          labelText: 'Confirm password',
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
          if (value != registerPasswordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
      ),
    );
  }
}
