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
  String phone = "0123456789";
  String country = "Egypt";
  final String role = "Tourist";
  bool showCountryOptions = false;

  late Future<UserModel> _userFuture;

  Future<UserModel> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate API delay
    return UserModel(
      id: 123,
      name: "ghada",
      email: "ghada@example.com",
      gender: "female",
      visits: 5,
      favorites: 3,
      role: role,
      country: country,
      phoneNumber: phone,
    );
  }

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserData(); // fix: fetch once
  }

  void _editPhone() {
    String updatedPhone = phone;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Phone"),
        content: TextFormField(
          initialValue: phone,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: "Enter phone number"),
          onChanged: (value) => updatedPhone = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() => phone = updatedPhone);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(AppText.profileError, style: TextStyle(color: AppColors.brown)),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(AppText.profileHasNoDate, style: TextStyle(color: AppColors.brown)),
          );
        }

        final user = snapshot.data!;

        return CustomScaffold(
          children: [
            UserProfileHeader(user: user),
            UserStatsCard(
              icon: Icons.person,
              title: "Name",
              value: user.name,
            ),
            UserStatsCard(
              icon: Icons.email,
              title: "Email",
              value: user.email,
            ),
            UserStatsCard(
              icon: Icons.male,
              title: "Gender",
              value: user.gender,
            ),
            UserStatsCard(
              icon: Icons.phone,
              title: "Phone",
              value: phone,
              trailingIcon: Icons.edit,
              onTap: _editPhone,
            ),
            Card(
              color: AppColors.transparentDarkCocoa,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.flag, color: AppColors.ivoryWhite),
                    title: const Text("Country",style: TextStyle(color:AppColors.ivoryWhite ),),
                    subtitle: Text(country),
                    trailing: Icon(
                      showCountryOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: AppColors.ivoryWhite,
                    ),
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
                          groupValue: country,
                          activeColor: AppColors.brown,
                          onChanged: (value) {
                            setState(() {
                              country = value.toString();
                              showCountryOptions = false;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("France"),
                          value: "France",
                          groupValue: country,
                          activeColor: AppColors.brown,
                          onChanged: (value) {
                            setState(() {
                              country = value.toString();
                              showCountryOptions = false;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            UserStatsCard(
              icon: Icons.verified_user,
              title: "Role",
              value: role,
            ),
          ],
        );
      },
    );
  }
}
