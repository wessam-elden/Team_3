import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/place_info.dart';
import '../../../../models.dart/landmark_model.dart';

class PlaceCard extends StatelessWidget {
  final Landmark place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlaceInfo(

                place: place,
              ),
            ),
          );
        },
        child: Container(
          width: 260,
          margin: const EdgeInsets.only(right: 16),
          child: Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: place.imageUrl != null && place.imageUrl!.isNotEmpty
                      ? Image.network(
                    place.imageUrl!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/images/placeholder.jpg', // صورة بديلة في حالة عدم وجود صورة
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.chestnutBrown,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        place.description ?? 'No description available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.brown, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
