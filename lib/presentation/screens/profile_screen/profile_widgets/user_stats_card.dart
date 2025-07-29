import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class UserStatsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  const UserStatsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparentDarkCocoa,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.white),
        title: Text(
          title,
          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(color: AppColors.white),
        ),
        trailing: IconButton(
          icon: Icon(trailingIcon, color: AppColors.white, size: 18),
          onPressed: onTap,
        ),
      ),
    );
  }
}
