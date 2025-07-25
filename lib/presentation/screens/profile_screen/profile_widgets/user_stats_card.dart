import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class UserStatsCard extends StatelessWidget {
  final String title;
  final String value;

  const UserStatsCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparentDarkCocoa,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: AppColors.white),
        ),
        trailing: Text(
          value,
          style: const TextStyle(color: AppColors.white,fontSize: 16),
        ),
      ),
    );
  }
}
