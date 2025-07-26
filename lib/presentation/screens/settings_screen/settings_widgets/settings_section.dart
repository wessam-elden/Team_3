import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/password_configuration/reset_password.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/build_card.dart';

class SettingsSection extends StatefulWidget {
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
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  String? selectedGender;
  bool showGenderOptions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //username card
        BuildCard(
          icon: Icons.face,
          title: AppText.username,
          subtitle: Text('${widget.firstName} ${widget.lastName}', style: TextStyle(color: AppColors.lightCocoa)),
          trailingIcon: Icons.edit,
          onTap: widget.onEditName,
        ),
        const SizedBox(height: 5),
        //email card
        const BuildCard(
          icon: Icons.email_outlined,
          title: AppText.email,
          subtitle: Text('ghada.af@yahoo.com', style: TextStyle(color: AppColors.lightCocoa)),
        ),
        const SizedBox(height: 5),
        // Gender Card
        BuildCard(
          icon: Icons.wc,
          title: AppText.gender,
          subtitle: Text(
            selectedGender ?? AppText.selectGender,
            style: TextStyle(color: AppColors.lightCocoa),
          ),
          trailingIcon: Icons.arrow_drop_down,
          onTap: () {
            setState(() {
              showGenderOptions = !showGenderOptions;
            });
          },
        ),

        if (showGenderOptions)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                _buildGenderOption(AppText.male),
                _buildGenderOption(AppText.female),
              ],
            ),
          ),

        const SizedBox(height: 5),
        //change pass card
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
        //logout card
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

  Widget _buildGenderOption(String gender) {
    return ListTile(
      title: Text(gender, style: TextStyle(color: AppColors.brown),),
      leading: Radio<String>(
        value: gender,
        activeColor: AppColors.brown,
        groupValue: selectedGender,
        onChanged: (value) {
          setState(() {
            selectedGender = value;
            showGenderOptions = false;
          });
        },
      ),
      onTap: () {
        setState(() {
          selectedGender = gender;
          showGenderOptions = false;
        });
      },
    );
  }
}
