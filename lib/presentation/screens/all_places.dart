import 'package:flutter/material.dart';
import 'package:maporia/models.dart/landmark_model.dart';
import 'package:maporia/presentation/screens/createcity.dart';
import 'package:maporia/presentation/screens/place_info.dart';

class AllPlacesPage extends StatelessWidget {
  final List<Landmark> places;
  final bool isAdmin;

  const AllPlacesPage({
    super.key,
    required this.places,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Places'),
        backgroundColor: const Color(0xFF8C5E3C),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlaceInfo(place: place),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      place.imageUrl ?? '',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8C5E3C),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          place.description ?? 'No description available.',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateCity.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF8C5E3C),
        tooltip: 'Add City',
      )
          : null,
    );
  }
}
