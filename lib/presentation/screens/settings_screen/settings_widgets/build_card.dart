import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class BuildCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? subtitle;
  final IconData? trailingIcon;
  final void Function()? onTap;

  const BuildCard({
    super.key,
    this.icon,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparentDarkCocoa,
      child: ListTile(
        leading: Icon(icon, color: AppColors.white),
        title: Text(
          title,
          style: const TextStyle(color:AppColors.white,),
        ),
        subtitle: subtitle,
        trailing: Icon(trailingIcon, color: AppColors.white, size: 16),
        onTap: onTap,
      ),
    );
  }
}
