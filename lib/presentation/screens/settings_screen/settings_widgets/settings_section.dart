// import statements as in your last message...

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
  final String name;
  final VoidCallback onEditName;

  const SettingsSection({
    super.key,
    required this.name,
    required this.onEditName,
  });

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool showCountryOptions = false;


  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserCubit>();

    return Column(
      children: [
        // username card
        BuildCard(
          icon: Icons.face,
          title: AppText.username,
          subtitle: Text(widget.name, style: const TextStyle(color: AppColors.lightCocoa)),
          trailingIcon: Icons.edit,
          onTap: widget.onEditName,
        ),
        const SizedBox(height: 5),

        // email card
        const BuildCard(
          icon: Icons.email_outlined,
          title: AppText.email,
          subtitle: Text('ghada.af@yahoo.com', style: TextStyle(color: AppColors.lightCocoa)),
        ),
        const SizedBox(height: 5),

        // change password card
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

        // phone
        BuildCard(
          icon: Icons.phone,
          title: AppText.phone,
          subtitle: Text(
            cubit.userPhone.isEmpty ? 'Add Number' : cubit.userPhone,
            style: const TextStyle(color: AppColors.white),
          ),
          trailingIcon: Icons.edit,
          onTap: () => showDialog(
            context: context,
            builder: (_) => EditPhoneDialog(currentPhone: cubit.userPhone),
          )
        ),
        const SizedBox(height: 5),

        // country
        BuildCard(
          icon: Icons.flag,
          title: AppText.country,
          subtitle: Text(
            cubit.userCountry.isEmpty ? 'Select Country' : cubit.userCountry,
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
            children: [
              RadioListTile(
                title: const Text("Egypt"),
                value: "Egypt",
                groupValue: cubit.userCountry,
                activeColor: AppColors.brown,
                onChanged: (value) {
                  context.read<UserCubit>().updateUserInfo(country: value.toString());
                  setState(() {
                    showCountryOptions = false;
                  });
                },
              ),
              RadioListTile(
                title: const Text("France"),
                value: "France",
                groupValue: cubit.userCountry,
                activeColor: AppColors.brown,
                onChanged: (value) {
                  context.read<UserCubit>().updateUserInfo(country: value.toString());
                  setState(() {
                    showCountryOptions = false;
                  });
                },
              ),
            ],
          ),
        const SizedBox(height: 5),

        // logout
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
