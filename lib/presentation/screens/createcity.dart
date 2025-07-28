import 'package:flutter/material.dart';

class CreateCity extends StatefulWidget {
  static String routeName = '/createCity';

  const CreateCity({super.key});

  @override
  State<CreateCity> createState() => _CreateCityState();
}

class _CreateCityState extends State<CreateCity> {
  final TextEditingController cityNameController = TextEditingController();

  @override
  void dispose() {
    cityNameController.dispose();
    super.dispose();
  }

  void _submitCity() {
    final cityName = cityNameController.text.trim();

    if (cityName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a city name')));
    } else {
      // حاليًا بدون API – مجرد رسالة للتأكيد
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('City "$cityName" created (mocked)!')),
      );
      cityNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New City')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter City Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cityNameController,
              decoration: InputDecoration(
                hintText: 'City name...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCity,
              // ignore: sort_child_properties_last
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
