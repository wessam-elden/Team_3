import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/favorites.dart';
import 'package:maporia/presentation/screens/profile.dart';
import 'package:maporia/presentation/screens/settings.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppColors.chestnutBrown,
        child: Row(
          children: [
            _buildNavItem(context, Icons.home, AppText.home, () {}, true),
            _buildNavItem(context, Icons.person, AppText.profile, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            }),
            const SizedBox(width: 40),
            _buildNavItem(context, Icons.star_border, AppText.favorites, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
            }),
            _buildNavItem(context, Icons.settings, AppText.settings, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, VoidCallback onTap, [bool isActive = false]) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.white, size: 24),
            ////need to be refactored
            Text(label, style: const TextStyle(color: AppColors.white, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
