import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/place_card.dart';


class Places extends StatelessWidget {
  static String routeName = '/places';
  final List<Map<String, String>> places;

  const Places({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivoryWhite,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return PlaceCard(place: place);
        },
      ),
    );
  }
}
