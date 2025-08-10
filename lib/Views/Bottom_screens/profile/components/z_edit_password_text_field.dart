import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/edit_profile_controller.dart';

class ZEditPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final EditProfileController editProfileController;
  const ZEditPasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    required this.editProfileController,
    this.obscureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller,
        validator: validator,
        obscureText: editProfileController.isPasswordVisible.value,
        keyboardType: TextInputType.visiblePassword,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              editProfileController.togglePasswordVisibility();
            },
            icon: Icon(
              editProfileController.isPasswordVisible.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            color: Color(0xff545454),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff545454).withAlpha(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff545454).withAlpha(50)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff545454).withAlpha(50),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
