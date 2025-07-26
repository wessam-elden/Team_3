import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';

class HomeHeaderImage extends StatelessWidget {
  const HomeHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.welcome),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
