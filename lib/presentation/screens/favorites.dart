import 'package:flutter/material.dart';
import 'detailsplace.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritesPage> {
  List<Map<String, String>> favoritePlaces = [
    {
      'title': 'The Great Pyramid of Giza',
      'description': 'The last remaining wonder of the ancient world.',
      'image': 'assets/images/pyramids.jpg',
    },
    {
      'title': 'Luxor Temple',
      'description':
          'An ancient Egyptian temple complex located on the east bank of the Nile.',
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
        builder:
            (context) => PlaceDetailsPage(
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
      backgroundColor: const Color(0xFFF5E6D8),
      appBar: AppBar(
        title: const Text('Favorite Places'),
        backgroundColor: const Color(0xFF8C5E3C),
      ),
      body:
          favoritePlaces.isEmpty
              ? const Center(
                child: Text(
                  'No favorite places yet.',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: favoritePlaces.length,
                itemBuilder: (context, index) {
                  final place = favoritePlaces[index];
                  return GestureDetector(
                    onTap: () => goToDetails(place),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                        title: Text(place['title']!),
                        subtitle: Text(
                          place['description']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () => removeFromFavorites(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
