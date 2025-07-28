import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/place_card.dart';
import '../../../models.dart/landmark_model.dart';

class Places extends StatelessWidget {
  static String routeName = '/places';
  final List<Landmark> places;

  const Places({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivoryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.ivoryWhite,
        elevation: 0,
        title: const Text(
          'All Places',
          style: TextStyle(
            color: AppColors.chestnutBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.chestnutBrown),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PlaceCard(place: place),
          );
        },
      ),
    );
  }
}
