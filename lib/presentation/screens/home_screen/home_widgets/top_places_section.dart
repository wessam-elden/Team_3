import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/places_screen/places.dart';
import '../../../../cubit/user_cubit.dart';
import '../../../../cubit/user_state.dart';
import '../../../../models.dart/landmark_model.dart';
import 'place_card.dart';


class TopPlacesSection extends StatelessWidget {
  final List<Landmark> places;
  final ScrollController scrollController;
  final VoidCallback onScrollLeft;
  final VoidCallback onScrollRight;
  final bool canScrollLeft;

  const TopPlacesSection({
    super.key,
    required this.places,
    required this.scrollController,
    required this.onScrollLeft,
    required this.onScrollRight,
    required this.canScrollLeft,
  });

  @override
  Widget build(BuildContext context) {
    List<Landmark> allLandmarks = [];


    final userState = context.watch<UserCubit>().state;
    if (userState is GetAllLandmarksSuccess) {
      allLandmarks = userState.landmarks;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppText.topPlaces,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.chestnutBrown,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Places(places: allLandmarks),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.chestnutBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(AppText.seeMore, style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 260,
          child: Stack(
            children: [
              ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  print("Place at index $index: ${place.name}, ID: ${place.id}");

                  return PlaceCard(place: place);
                },
              ),

              if (canScrollLeft)
                Align(
                  alignment: Alignment.centerLeft,
                  child: _arrowButton(Icons.arrow_back, onScrollLeft),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: _arrowButton(Icons.arrow_forward, onScrollRight),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _arrowButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.chestnutBrown,
      ),
      child: IconButton(icon: Icon(icon, color: AppColors.white), onPressed: onTap),
    );
  }
}