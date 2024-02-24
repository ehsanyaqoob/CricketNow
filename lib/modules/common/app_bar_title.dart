import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/ic_logo.png",
          width: 28,
        ),
        const SizedBox(
          width: 5.0,
        ),
        const Text(
          "CRIC",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            letterSpacing: 1,
          ),
        ),
        const Text(
          "NOW",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
