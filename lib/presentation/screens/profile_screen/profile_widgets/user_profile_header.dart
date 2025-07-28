import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/constants/app_colors.dart';
// ignore: unused_import
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/models.dart/user_model.dart';

class UserProfileHeader extends StatelessWidget {
  final UserModel user;

  const UserProfileHeader({super.key, required this.user});

  String getAvatar(String gender) {
    return gender == 'male' ? AppAssets.male : AppAssets.female;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(getAvatar(user.gender)),
          backgroundColor: AppColors.ivoryWhite,
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.brown,
          ),
        ),
        Text(
          user.email,
          style: const TextStyle(color: AppColors.brown, fontSize: 15),
        ),
        SizedBox(height: 2),
        Text(
          user.gender,
          style: const TextStyle(color: AppColors.brown, fontSize: 15),
        ),
      ],
    );
  }
}
