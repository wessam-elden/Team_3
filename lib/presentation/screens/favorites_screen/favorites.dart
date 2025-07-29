import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/favorites_screen/favorites_widgets/favorite_card.dart';
import '../../../models.dart/landmark_model.dart';
import '../place_info.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritesPage> {
  List<Landmark> favoritePlaces = [
    Landmark(
      id: 1,
      name: 'The Great Pyramid of Giza',
      description: 'The last remaining wonder of the ancient world.',
      imageUrl: 'assets/images/pyramids.jpg',
      location: 'Giza, Egypt',
      cityId: 1,

    ),
    Landmark(
      id: 2,
      name: 'Luxor Temple',
      description: 'An ancient Egyptian temple complex located on the east bank of the Nile.',
      imageUrl: 'assets/images/karnak.jpg',
      location: 'Luxor, Egypt',
      cityId: 2,
    ),
    Landmark(
      id: 3,
      name: 'Abu Simbel Temples',
      description: 'Massive rock temples built by Pharaoh Ramses II.',
      imageUrl: 'assets/images/abusimbel.jpg',
      location: 'Aswan, Egypt',
      cityId: 3,
    ),
  ];

  void removeFromFavorites(int index) {
    setState(() {
      favoritePlaces.removeAt(index);
    });
  }

  void goToDetails(Landmark place)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlaceInfo(
          title: place.name,
          description: place.description ?? '',
          image: place.imageUrl ?? '',
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivoryWhite,
      body:
          favoritePlaces.isEmpty
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
