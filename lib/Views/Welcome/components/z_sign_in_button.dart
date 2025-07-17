import 'package:flutter/material.dart';

class ZSignInButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bColor;
  final Color fColor;
  final FontWeight fontWeight;
  final double fontSize;
  final Size size;
  const ZSignInButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.bColor,
    required this.fColor,
    required this.fontWeight,
    required this.fontSize,
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
