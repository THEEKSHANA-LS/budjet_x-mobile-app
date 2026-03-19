import 'package:budjet_x/constants/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", width: 100, fit: BoxFit.cover),

        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Budget_x",
            style: TextStyle(
              fontSize: 40,
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
