import 'package:flutter/material.dart';
import 'package:unity_project/controllers/auth_controllers.dart';

class DisplayNameTextField extends StatelessWidget {
  final TextEditingController displayNameController;
  final AuthController controller;
  const DisplayNameTextField({
    super.key,
    required this.displayNameController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: displayNameController,
      onTapOutside: (event) {
        controller.unfocusKeyboard();
      },
      keyboardType: TextInputType.name,
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
        labelText: 'Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xff545454),
          fontSize: 18,
        ),
        hintText: 'Enter Your Full Name',
        hintStyle: TextStyle(color: Color(0xff545454).withAlpha(100)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name field is required";
        }
        if (!controller.isValidName(value)) {
          return "Name must be at least 3 characters long";
        }
        return null;
      },
    );
  }
}
