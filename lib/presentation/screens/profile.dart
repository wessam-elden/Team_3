// ignore: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models.dart/user_model.dart';
// ignore: unused_import
import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<UserModel> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    final fakeJson = {
      "name": "Mohamed",
      "email": "mohamed@example.com",
      "gender": "male",
      "visits": 12,
      "favorites": 7,
    };

    return UserModel.fromJson(fakeJson);

    //لما يكون معايا الAPI
    /*
    final response = await http.get(Uri.parse('https://your-api.com/user'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data upload failure');
    }
    */
  }

  String getAvatar(String gender) {
    return gender == 'male'
        ? 'assets/images/profile_boy.jpg'
        : 'assets/images/profile_girl.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("An error occurred while loading data"),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text("There is no data available"));
          }

          final user = snapshot.data!;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(getAvatar(user.gender)),
                  ),
                  const SizedBox(height: 16),

                  Stack(
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          foreground:
                              Paint()
                                ..style = ui.PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = const Color.fromARGB(255, 114, 57, 0),
                        ),
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 254, 254),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox("Visits", user.visits),
                        _buildStatBox("Favorites", user.favorites),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatBox(String label, int value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "$value",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
