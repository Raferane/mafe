import 'package:flutter/material.dart';

class ZGuestTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color fColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  const ZGuestTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fColor,
    required this.fontSize,
    required this.fontWeight,
    required this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fColor,
          decoration: textDecoration,
        ),
      ),
    );
  }
}
