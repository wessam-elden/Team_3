// ignore: file_names
import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/constants/app_colors.dart';

class SignWith extends StatelessWidget {
  const SignWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildContainer(AppAssets.google),
      ],
    );
  }

  InkWell buildContainer(String image) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Image.asset(image),
      ),
    );
  }
}
