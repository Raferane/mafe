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
            color: Colors.grey[400],
            indent: 20,
            endIndent: 10,
            thickness: 1.5,
          ),
        ),
        Text(
          "OR",
          style: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            endIndent: 20,
            indent: 10,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
