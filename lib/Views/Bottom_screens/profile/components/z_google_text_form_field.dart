import 'package:flutter/material.dart';

class ZGoogleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final VoidCallback? onDisabledTap;
  const ZGoogleTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.onDisabledTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDisabledTap,
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            color: Color(0xff545454),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          suffix: Icon(Icons.lock_outline, color: Color(0xff545454), size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff545454).withAlpha(50)),
          ),
          disabledBorder: OutlineInputBorder(
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
        onTapOutside: (event) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
