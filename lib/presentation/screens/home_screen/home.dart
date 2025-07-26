import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/custom_bottom_nav_bar.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/bot_button.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/city_selector.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/home_header_image.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/search_field.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/top_places_section.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //static until the api integration
  final List<String> cities = ['Cairo', 'Luxor', 'Alexandria', 'Aswan', 'Giza'];
  String selectedCity = 'Cairo';

  String searchQuery = '';
  Offset _botOffset = const Offset(20, 100);
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;

  //static until the api integration
  final Map<String, List<Map<String, String>>> cityPlaces = {
    'Cairo': [
      {'title': 'Pyramids', 'description': 'One of the ancient wonders of the world.', 'image': 'assets/images/pyramids.jpg'},
      {'title': 'Citadel', 'description': 'Historic Islamic-era fortress in Cairo.', 'image': 'assets/images/qaitbay.jpg'},
    ],
    'Giza': [
      {'title': 'Pyramids', 'description': 'One of the ancient wonders of the world.', 'image': 'assets/images/pyramids.jpg'},
    ],
    'Luxor': [
      {'title': 'Karnak Temple', 'description': 'One of the largest ancient temples.', 'image': 'assets/images/karnak.jpg'},
    ],
    'Alexandria': [
      {'title': 'Qaitbay Citadel', 'description': 'Historic fortress on the Mediterranean coast.', 'image': 'assets/images/qaitbay.jpg'},
    ],
    'Aswan': [
      {'title': 'Philae Temple', 'description': 'Ancient temple complex in Aswan.', 'image': 'assets/images/philae.jpg'},
    ],
  };

  final ImagePicker _picker = ImagePicker();

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
      //will be deleted after the api integration
      print("Camera opened and image captured: ${photo.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = cityPlaces[selectedCity]!
        .where((place) => place['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.ivoryWhite ,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: false,
                expandedHeight: 250,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: HomeHeaderImage(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CitySelector(
                        cities: cities,
                        selectedCity: selectedCity,
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      SearchField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TopPlacesSection(
                        places: filteredPlaces,
                        scrollController: _scrollController,
                        onScrollLeft: _scrollLeft,
                        onScrollRight: _scrollRight,
                        canScrollLeft: _canScrollLeft,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: _botOffset.dx,
            top: _botOffset.dy.clamp(0.0, MediaQuery.of(context).size.height - 130),
            child: BotButton(
              initialOffset: _botOffset,
              onDragEnd: (offset) {
                setState(() {
                  _botOffset = Offset(offset.dx, offset.dy.clamp(0.0, MediaQuery.of(context).size.height - 130));
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        backgroundColor: AppColors.chestnutBrown,
        shape: const CircleBorder(side: BorderSide(color: AppColors.white, width: 3)),
        child: const Icon(Icons.camera_alt, color: AppColors.white, size: 30),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
