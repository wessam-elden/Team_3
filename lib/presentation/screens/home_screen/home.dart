import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/screens/all_places.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/custom_bottom_nav_bar.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/bot_button.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/city_selector.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/home_header_image.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/search_field.dart';
import 'package:maporia/presentation/screens/home_screen/home_widgets/top_places_section.dart';

import '../../../cubit/user_cubit.dart';
import '../../../models.dart/createCity_model.dart';
import '../../../models.dart/landmark_model.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //static until the api integration
  List<City> cities = [];
  City? selectedCity;
  List<Landmark> landmarks = [];


  String searchQuery = '';
  Offset _botOffset = const Offset(20, 100);
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getAllCities();
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

    // final filteredPlaces =
    //     cityPlaces[selectedCity]!
    //         .where(
    //           (place) => place['title']!.toLowerCase().contains(
    //             searchQuery.toLowerCase(),
    //           ),
    //         )
    //         .toList();
    // final filteredPlaces = cityPlaces[selectedCity]!
    //      .where((place) => place['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
    //      .toList();

    return Scaffold(
      backgroundColor: AppColors.ivoryWhite,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: false,
                expandedHeight: 250,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(background: HomeHeaderImage()),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is GetAllCitiesLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is GetAllCitiesSuccess) {
                            cities = state.cities;
                            selectedCity ??= cities.first;
                            if (landmarks.isEmpty && selectedCity != null) {
                              context.read<UserCubit>().getLandmarksByCityId(selectedCity!.id);
                            }
                          }
                          else if (state is GetAllCitiesFailure) {
                            return Text(state.errMessage, style: TextStyle(color: Colors.red));
                          }


                          return CitySelector(
                            cities: cities,
                            selectedCity: selectedCity!,
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value;
                              });
                              context.read<UserCubit>().getLandmarksByCityId(value.id);
                            },
                          );

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
                      BlocBuilder<UserCubit, UserState>(
                        builder: (BuildContext context, UserState state) {
                          List<Landmark> filteredPlaces = [];

                          if (state is GetLandmarksByCityLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is GetLandmarksByCitySuccess) {
                            filteredPlaces = state.landmarks
                                .where((place) =>
                                place.name.toLowerCase().contains(searchQuery.toLowerCase()))
                                .toList();
                          } else if (state is GetLandmarksByCityFailure) {
                            return Text(state.errMessage, style: const TextStyle(color: Colors.red));
                          }

                          return TopPlacesSection(
                            places: filteredPlaces,
                            scrollController: _scrollController,
                            onScrollLeft: _scrollLeft,
                            onScrollRight: _scrollRight,
                            canScrollLeft: _canScrollLeft,
                          );

                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brown,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.place, color: Colors.white),
                        label: const Text(
                          'View All Places',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder:
                          //         (_) => AllPlacesPage(
                          //           places: cityPlaces[selectedCity]!,
                          //           isAdmin: true, // ← اعتبره Admin هنا
                          //         ),
                          //   ),
                          //);
                        },
                      )
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
            child: BotButton(
              initialOffset: _botOffset,
              onDragEnd: (offset) {
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
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openCamera,
        backgroundColor: AppColors.chestnutBrown,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.white, width: 3),
        ),
        child: const Icon(Icons.camera_alt, color: AppColors.white, size: 30),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
