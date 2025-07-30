import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/models.dart/user_model.dart';
import 'package:maporia/presentation/screens/profile_screen/profile_widgets/user_profile_header.dart';
import 'package:maporia/presentation/screens/profile_screen/profile_widgets/user_stats_card.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';

class Profile extends StatefulWidget {
  static String routeName = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserCubit>();

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is GetProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProfileFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return CustomScaffold(
            children: [
              UserProfileHeader(
                user: UserModel(
                  id: 0,
                  name: cubit.profileNameController.text,
                  email: cubit.profileEmailController.text,
                  visits: 5,
                  favorites: 3,
                  role: cubit.profileRoleController.text,
                  country: cubit.profileCountryController.text.isEmpty
                      ? "Country not selected"
                      : cubit.profileCountryController.text,
                  phoneNumber: cubit.profilePhoneController.text.isEmpty
                      ? "No phone number added"
                      : cubit.profilePhoneController.text,
                ),
              ),
              UserStatsCard(
                icon: Icons.person,
                title: AppText.name,
                value: cubit.profileNameController.text,
              ),
              UserStatsCard(
                icon: Icons.email,
                title: AppText.email,
                value: cubit.profileEmailController.text,
              ),
              UserStatsCard(
                icon: Icons.phone,
                title: AppText.phone,
                value: cubit.profilePhoneController.text.isEmpty
                    ? "No phone number added"
                    : cubit.profilePhoneController.text,
              ),
              UserStatsCard(
                icon: Icons.flag,
                title: AppText.country,
                value: cubit.profileCountryController.text.isEmpty
                    ? "Country not selected"
                    : cubit.profileCountryController.text,
              ),
              UserStatsCard(
                icon: Icons.verified_user,
                title: AppText.role,
                value: cubit.profileRoleController.text,
              ),
            ],
          );
        }
      },
    );
  }
}
