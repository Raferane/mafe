import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/controllers/edit_profile_controller.dart';

class ZEditConfirmPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final EditProfileController editProfileController;
  final bool isEnabled;
  final VoidCallback? onDisabledTap;
  const ZEditConfirmPasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    required this.editProfileController,
    this.obscureText = true,
    this.isEnabled = true,
    this.onDisabledTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: isEnabled ? null : onDisabledTap,
        behavior: HitTestBehavior.translucent,
        child: TextFormField(
          controller: controller,
          enabled: isEnabled,
          validator: isEnabled ? validator : (_) => null,
          obscureText: editProfileController.isConfirmPasswordVisible.value,
          keyboardType: TextInputType.visiblePassword,
          onTapOutside: (event) {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                editProfileController.toggleConfirmPasswordVisibility();
              },
              icon:
                  isEnabled
                      ? Icon(
                        editProfileController.isConfirmPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      )
                      : Icon(
                        Icons.lock_outline,
                        color: Color(0xff545454),
                        size: 20,
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
      ),
    );
  }
}
