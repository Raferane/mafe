import 'package:flutter/material.dart';

class ZSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ZSubmitButton({super.key, required this.onPressed, required this.text});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.green[500],
      textColor: Colors.white,
      minWidth: 300,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: TextStyle(fontSize: 18)),
    );
  }
}
