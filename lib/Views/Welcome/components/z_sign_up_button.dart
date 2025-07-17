import 'package:flutter/material.dart';

class ZSignUpButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bColor;
  final Color fColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Size size;
  const ZSignUpButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.bColor,
    required this.fColor,
    required this.fontSize,
    required this.fontWeight,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bColor,
        foregroundColor: fColor,
        fixedSize: size,
        elevation: 3,
        shadowColor: Color(0xfff2e29f).withAlpha(150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: fColor, width: 1),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
