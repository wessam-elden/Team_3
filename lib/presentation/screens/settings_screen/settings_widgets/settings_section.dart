import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/password_configuration/reset_password.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/build_card.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/edit_phone_dialog.dart';

class SettingsSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onEditName;
  final TextEditingController phoneController;
  final TextEditingController countryController;

  const SettingsSection({
    super.key,
    required this.nameController,
    required this.onEditName,
    required this.phoneController,
    required this.countryController,
    required this.emailController,
  });

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool showCountryOptions = false;

  final List<String> countries = [
    'Egypt',
    'France',
    'United States',
    'Germany',
    'Italy',
    'United Kingdom',
    'Spain',
    'Canada',
    'Brazil',
    'Saudi Arabia',
    'United Arab Emirates',
    'Turkey',
    'Japan',
    'China',
    'India',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Username
        BuildCard(
          icon: Icons.face,
          title: AppText.username,
          subtitle: Text(
            widget.nameController.text.isEmpty ? "No name" : widget.nameController.text,
            style: const TextStyle(color: AppColors.lightCocoa),
          ),
          trailingIcon: Icons.edit,
          onTap: widget.onEditName,
        ),
        const SizedBox(height: 5),

        // Email (ثابت)
        BuildCard(
          icon: Icons.email_outlined,
          title: AppText.email,
          subtitle: Text(
            widget.emailController.text.isEmpty ? "No email" : widget.emailController.text,
            style: const TextStyle(color: AppColors.lightCocoa),
          ),
        ),
        const SizedBox(height: 5),

        // Change password
        BuildCard(
          icon: Icons.vpn_key,
          title: AppText.changePassword,
          trailingIcon: Icons.arrow_forward_ios,
          subtitle: null,
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

        // Phone
        BuildCard(
          icon: Icons.phone,
          title: AppText.phone,
          subtitle: Text(
            widget.phoneController.text.isEmpty ? AppText.addNumber : widget.phoneController.text,
            style: const TextStyle(color: AppColors.white),
          ),
          trailingIcon: Icons.edit,
          onTap: () => showDialog(
            context: context,
            builder: (_) => EditPhoneDialog(currentPhone: widget.phoneController.text),
          ),
        ),
        const SizedBox(height: 5),

        // Country
        BuildCard(
          icon: Icons.flag,
          title: AppText.country,
          subtitle: Text(
            widget.countryController.text.isEmpty ? AppText.selectCountry : widget.countryController.text,
            style: const TextStyle(color: AppColors.white),
          ),
          trailingIcon: showCountryOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          onTap: () {
            setState(() {
              showCountryOptions = !showCountryOptions;
            });
          },
        ),

        if (showCountryOptions)
          Column(
            children: countries.map((country) {
              return RadioListTile<String>(
                title: Text(country),
                value: country,
                groupValue: widget.countryController.text,
                activeColor: AppColors.brown,
                onChanged: (value) {
                 // context.read<UserCubit>().updateUserInfo(country: value!);
                  //widget.countryController.text = value;
                  setState(() {
                    showCountryOptions = false;
                  });
                },
              );
            }).toList(),
          ),

        const SizedBox(height: 5),

        // Logout
        BuildCard(
          subtitle: null,
          icon: Icons.logout,
          title: AppText.logout,
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
