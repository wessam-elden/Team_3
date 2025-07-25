import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/place_info.dart';
import 'package:maporia/presentation/screens/favorites_screen/favorites_widgets/favorite_card.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritesPage> {
  // will be removed after the API integration
  List<Map<String, String>> favoritePlaces = [
    {
      'title': 'The Great Pyramid of Giza',
      'description': 'The last remaining wonder of the ancient world.',
      'image': 'assets/images/pyramids.jpg',
    },
    {
      'title': 'Luxor Temple',
      'description': 'An ancient Egyptian temple complex located on the east bank of the Nile.',
      'image': 'assets/images/karnak.jpg',
    },
    {
      'title': 'Abu Simbel Temples',
      'description': 'Massive rock temples built by Pharaoh Ramses II.',
      'image': 'assets/images/abusimbel.jpg',
    },
  ];

  void removeFromFavorites(int index) {
    setState(() {
      favoritePlaces.removeAt(index);
    });
  }

  void goToDetails(Map<String, String> place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlaceInfo(
          title: place['title']!,
          description: place['description']!,
          image: place['image']!,
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivoryWhite,
      body: favoritePlaces.isEmpty
          ? const Center(
        child: Text(
          AppText.emptyFav,
          style: TextStyle(color: AppColors.brown, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favoritePlaces.length,
        itemBuilder: (context, index) {
          final place = favoritePlaces[index];
          return FavoriteCard(
            place: place,
            onRemove: () => removeFromFavorites(index),
            onTap: () => goToDetails(place),
          );
        },
      ),
    );
  }
}
