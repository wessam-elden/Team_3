import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AppAssets.background, fit: BoxFit.cover),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/shadow.png',
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
