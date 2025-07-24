import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/all_places.dart';
import 'package:maporia/presentation/screens/chatbot.dart';
import 'package:maporia/presentation/screens/detailsplace.dart';
import 'package:maporia/presentation/screens/favorites.dart';
import 'package:maporia/presentation/screens/profile.dart';
import 'package:maporia/presentation/screens/settings.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> cities = ['Cairo', 'Luxor', 'Alexandria', 'Aswan', 'Giza'];
  String selectedCity = 'Cairo';

  final Map<String, List<Map<String, String>>> cityPlaces = {
    'Cairo': [
      {
        'title': 'Pyramids',
        'description': 'One of the ancient wonders of the world.',
        'image': 'assets/images/pyramids.jpg',
      },
      {
        'title': 'Citadel',
        'description': 'Historic Islamic-era fortress in Cairo.',
        'image': 'assets/images/qaitbay.jpg',
      },
    ],
    'Giza': [
      {
        'title': 'Pyramids',
        'description': 'One of the ancient wonders of the world.',
        'image': 'assets/images/pyramids.jpg',
      },
    ],
    'Luxor': [
      {
        'title': 'Karnak Temple',
        'description': 'One of the largest ancient temples.',
        'image': 'assets/images/karnak.jpg',
      },
    ],
    'Alexandria': [
      {
        'title': 'Qaitbay Citadel',
        'description': 'Historic fortress on the Mediterranean coast.',
        'image': 'assets/images/qaitbay.jpg',
      },
    ],
    'Aswan': [
      {
        'title': 'Philae Temple',
        'description': 'Ancient temple complex in Aswan.',
        'image': 'assets/images/philae.jpg',
      },
    ],
  };

  String searchQuery = '';
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  final ImagePicker _picker = ImagePicker();
  Offset _botOffset = const Offset(20, 100);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _canScrollLeft = _scrollController.offset > 0;
      });
    });
  }

  void _scrollRight() {
    final nextScroll = (_scrollController.offset + 200).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      nextScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollLeft() {
    final prevScroll = (_scrollController.offset - 200).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      prevScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      // ignore: avoid_print
      print("Camera opened and image captured: ${photo.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces =
        cityPlaces[selectedCity]!
            .where(
              (place) => place['title']!.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E1),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                expandedHeight: 250,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/welcome.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Select a City',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 104, 47, 12),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.flight_rounded, color: Color(0xFF8C5E3C)),
                        ],
                      ),
                      DropdownButton<String>(
                        value: selectedCity,
                        isExpanded: true,
                        dropdownColor: const Color(0xFFF5F0E1),
                        iconEnabledColor: const Color(0xFF8C5E3C),
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value!;
                          });
                        },
                        items:
                            cities.map((city) {
                              IconData icon;
                              switch (city) {
                                case 'Cairo':
                                  icon = Icons.location_city;
                                  break;
                                case 'Luxor':
                                  icon = Icons.temple_buddhist;
                                  break;
                                case 'Alexandria':
                                  icon = Icons.beach_access;
                                  break;
                                case 'Giza':
                                  icon = Icons.landscape;
                                  break;
                                default:
                                  icon = Icons.temple_buddhist_outlined;
                              }
                              return DropdownMenuItem(
                                value: city,
                                child: Row(
                                  children: [
                                    Icon(
                                      icon,
                                      color: Color(0xFF8C5E3C),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      city,
                                      style: const TextStyle(
                                        color: Color(0xFF8C5E3C),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        underline: Container(
                          height: 1,
                          color: const Color(0xFF8C5E3C),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for a place...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 136, 128, 122),
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF8C5E3C),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFF8C5E3C),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFF8C5E3C),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFF8C5E3C),
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Top Places',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8C5E3C),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          AllPlacesPage(places: filteredPlaces),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C5E3C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 260,
                        child: Stack(
                          children: [
                            ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: filteredPlaces.length,
                              itemBuilder: (context, index) {
                                final place = filteredPlaces[index];
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => PlaceDetailsPage(
                                                title: place['title']!,
                                                description:
                                                    place['description']!,
                                                image: place['image']!,
                                                place: {},
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 260,
                                      margin: const EdgeInsets.only(right: 16),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                              child: Image.asset(
                                                place['image']!,
                                                width: double.infinity,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    place['title']!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF8C5E3C),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    place['description']!,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
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
                              },
                            ),
                            if (_canScrollLeft)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF8C5E3C),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: _scrollLeft,
                                  ),
                                ),
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF8C5E3C),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  onPressed: _scrollRight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: _botOffset.dx,
            top: _botOffset.dy.clamp(
              0.0,
              MediaQuery.of(context).size.height - 130,
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Draggable(
                feedback: _buildBotButton(),
                childWhenDragging: Container(),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    _botOffset = Offset(
                      offset.dx,
                      offset.dy.clamp(
                        0.0,
                        MediaQuery.of(context).size.height - 130,
                      ),
                    );
                  });
                },
                child: _buildBotButton(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        backgroundColor: const Color(0xFF8C5E3C),
        // ignore: sort_child_properties_last
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 3),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: const Color(0xFF8C5E3C),
          child: Row(
            children: [
              _buildNavItem(Icons.home, "Home", () {}, true),
              _buildNavItem(Icons.person, "Profile", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              }),
              const SizedBox(width: 40),
              _buildNavItem(Icons.star_border, "Favorites", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesPage()),
                );
              }),
              _buildNavItem(Icons.settings, "Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    VoidCallback onTap, [
    bool isActive = false,
  ]) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBotButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatBotPage()),
        );
      },
      child: const CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage("assets/images/bot.png"),
      ),
    );
  }
}
