import 'package:flutter/material.dart';

class PlaceDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const PlaceDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required Map<String, String> place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF8C5E3C),
      ),
      body: Column(
        children: [
          Image.asset(
            image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description, style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
