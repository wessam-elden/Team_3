import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
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
  Future<UserModel> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    //will be deleted after API integration
    final fakeJson = {
      "name": "Mohamed",
      "email": "mohamed@example.com",
      "gender": "male",
      "visits": 12,
      "favorites": 7,
    };

    return UserModel.fromJson(fakeJson);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        FutureBuilder<UserModel>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  AppText.profileError,
                  style: TextStyle(color: AppColors.brown),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  AppText.profileHasNoDate,
                  style: TextStyle(color: AppColors.brown),
                ),
              );
            }

            final user = snapshot.data!;

            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  UserProfileHeader(user: user),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    child: Divider(color: AppColors.brown, thickness: 0.5),
                  ),
                  UserStatsCard(
                    title: AppText.visits,
                    value: user.visits.toString(),
                  ),
                  const SizedBox(height: 5),
                  UserStatsCard(
                    title: AppText.visits,
                    value: user.favorites.toString(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
