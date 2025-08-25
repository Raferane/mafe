import 'package:flutter/material.dart';

class ZEditTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextStyle? style;
  const ZEditTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: style,
      onTapOutside: (event) {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
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
    );
  }
}
