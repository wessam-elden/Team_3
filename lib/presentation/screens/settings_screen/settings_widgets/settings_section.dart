import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/password_configuration/reset_password.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/build_card.dart';


class SettingsSection extends StatelessWidget {
  final String firstName;
  final String lastName;
  final VoidCallback onEditName;

  const SettingsSection({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.onEditName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildCard(
          icon: Icons.face,
          title: AppText.username,
          subtitle: Text('$firstName $lastName', style: TextStyle(color: AppColors.lightCocoa)),
          trailingIcon: Icons.edit,
          onTap: onEditName,
        ),
        const SizedBox(height: 5),
        const BuildCard(
          icon: Icons.email_outlined,
          title: AppText.email,
          //will be changed according to the user's email
          subtitle: Text('ghada.af@yahoo.com', style: TextStyle(color: AppColors.lightCocoa)),
        ),
        const SizedBox(height: 5),
        BuildCard(
          icon: Icons.vpn_key,
          title: AppText.changePassword,
          subtitle: null,
          trailingIcon: Icons.arrow_forward_ios,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPassword(needCurrentPassword: true),
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        BuildCard(
          icon: Icons.logout,
          title: AppText.logout,
          subtitle: null,
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Login.routeName,
                  (route) => false,
            );
          },
        ),
      ],
    );
  }
}
