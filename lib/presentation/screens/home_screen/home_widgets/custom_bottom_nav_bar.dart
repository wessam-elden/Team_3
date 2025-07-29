import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/presentation/screens/favorites_screen/favorites.dart';
import 'package:maporia/presentation/screens/profile_screen/profile.dart';
import 'package:maporia/presentation/screens/settings_screen/settings.dart';


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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<UserCubit>(),
                    child: const Profile(),
                  ),
                ),
              );
            }),
            const SizedBox(width: 40),
            _buildNavItem(context, Icons.star_border, AppText.favorites, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
            }),
            _buildNavItem(context, Icons.settings, AppText.settings, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Settings()));
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
