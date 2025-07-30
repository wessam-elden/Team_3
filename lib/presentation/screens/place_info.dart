import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models.dart/landmark_model.dart';

class PlaceInfo extends StatelessWidget {
  final Landmark place;

  const PlaceInfo({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              place.imageUrl != null
                  ? Image.network(
                place.imageUrl!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
                  : Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey,
                child: const Center(child: Text("No image")),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  place.description ?? "No description",
                  style: const TextStyle(fontSize: 18),
                ),
              ),

                  if (place.location.isNotEmpty)
          Text("Location: ${place.location}", style: TextStyle(fontSize: 16)),

        if (place.openingHours != null)
    Text("Opening Hours: ${place.openingHours}", style: TextStyle(fontSize: 16)),

    if (place.ticketPrice != null)
    Text("Ticket Price: \$${place.ticketPrice}", style: TextStyle(fontSize: 16)),


            ],
          ),
        ),
      ),
    );
  }
}
