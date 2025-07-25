import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class FavoriteCard extends StatelessWidget {
  final Map<String, String> place;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavoriteCard({
    super.key,
    required this.place,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              place['image']!,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            place['title']!,
            style: const TextStyle(color: AppColors.brown),
          ),
          subtitle: Text(
            place['description']!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.chestnutBrown),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: AppColors.red),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
