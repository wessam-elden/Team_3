import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/models.dart/user_model.dart';
import 'package:maporia/presentation/screens/profile_screen/profile_widgets/user_profile_header.dart';
import 'package:maporia/presentation/screens/profile_screen/profile_widgets/user_stats_card.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';

class Profile extends StatelessWidget {
  static String routeName = '/profile';
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserCubit>();

    final String displayedPhone =
    cubit.userPhone.isEmpty ? "No phone number added" : cubit.userPhone;

    final String displayedCountry =
    cubit.userCountry.isEmpty ? "Country not selected" : cubit.userCountry;

    return CustomScaffold(
      children: [
        UserProfileHeader(
          user: UserModel(
            id: 0,
            name: cubit.userName,
            email: "ghada@example.com",
            visits: 5,
            favorites: 3,
            role: cubit.userRole,
            country: displayedCountry,
            phoneNumber: displayedPhone,
          ),
        ),
        UserStatsCard(
          icon: Icons.person,
          title: AppText.name,
          value: cubit.userName,
        ),
        UserStatsCard(
          icon: Icons.email,
          title: AppText.email,
          value: "ghada@example.com",
        ),
        UserStatsCard(
          icon: Icons.phone,
          title: AppText.phone,
          value: displayedPhone,
          trailingIcon: null,
          onTap: null,
        ),
        UserStatsCard(
          icon: Icons.flag,
          title: AppText.country,
          value: displayedCountry,
          trailingIcon: null,
          onTap: null,
        ),
        UserStatsCard(
          icon: Icons.verified_user,
          title: AppText.role,
          value: cubit.userRole,
        ),
      ],
    );
  }
}
