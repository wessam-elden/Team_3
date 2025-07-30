import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/place_info.dart';

import '../../../../models.dart/landmark_model.dart';

class PlaceCard extends StatelessWidget {
  final Landmark place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildTextContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: place.imageUrl != null && place.imageUrl!.isNotEmpty
          ? Image.network(
        place.imageUrl!,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      )
          : Image.asset(
        'assets/images/placeholder.jpg',
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTextContent() {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.brown,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            place.description ?? 'No description available',
            style: const TextStyle(
              color: AppColors.chestnutBrown,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
