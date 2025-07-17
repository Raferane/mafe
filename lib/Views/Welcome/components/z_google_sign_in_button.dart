import 'package:flutter/material.dart';

class ZGoogleSignInButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bColor;
  final Color fColor;
  final Size size;
  final double fontSize;
  final FontWeight fontWeight;
  const ZGoogleSignInButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.bColor,
    required this.fColor,
    required this.size,
    required this.fontSize,
    required this.fontWeight,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/google_icon.png', width: 25, height: 25),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}
