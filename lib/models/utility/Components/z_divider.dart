import 'package:flutter/material.dart';

class ZDivider extends StatelessWidget {
  const ZDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Color(0xff2c2c2c).withAlpha(140),
            indent: 20,
            endIndent: 10,
            thickness: 1.5,
          ),
        ),
        Text(
          "Or continue with",
          style: TextStyle(
            color: Color(0xff2c2c2c).withAlpha(140),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xff2c2c2c).withAlpha(140),
            endIndent: 20,
            indent: 10,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
