import '../models.dart/createCity_model.dart';
import '../models.dart/landmark_model.dart';

class UserState {}

final class UserInitial extends UserState {}
final class LoginInSuccess extends UserState {
  final String message;

  LoginInSuccess({required this.message});
}

final class LoginInLoading extends UserState {}
final class LoginInFailure extends UserState {
  final String errMessage;
  LoginInFailure({required this.errMessage});
}



final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}
final class SignUpLoading extends UserState {}
final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

//create city states
final class CreateCityLoading extends UserState {}
final class CreateCitySuccess extends UserState {
  final String message;
  final City city;

  CreateCitySuccess({required this.message, required this.city});
}
final class CreateCityFailure extends UserState {
  final String errMessage;

  CreateCityFailure({required this.errMessage});
}

// Get All Cities
final class GetAllCitiesLoading extends UserState {}

final class GetAllCitiesSuccess extends UserState {
  final List<City> cities;
  GetAllCitiesSuccess({required this.cities});
}

final class GetAllCitiesFailure extends UserState {
  final String errMessage;
  GetAllCitiesFailure({required this.errMessage});
}


//create landmark states
final class CreateLandmarkLoading extends UserState {}

final class CreateLandmarkSuccess extends UserState {
  final String message;
  final Landmark landmark;

  CreateLandmarkSuccess({required this.message, required this.landmark});
}

final class CreateLandmarkFailure extends UserState {
  final String errMessage;

  CreateLandmarkFailure({required this.errMessage});
}


// Get All Landmarks
final class GetAllLandmarksLoading extends UserState {}
final class GetAllLandmarksSuccess extends UserState {
  final List<Landmark> landmarks;
  GetAllLandmarksSuccess({required this.landmarks});
}
final class GetAllLandmarksFailure extends UserState {
  final String errMessage;
  GetAllLandmarksFailure({required this.errMessage});
}

// Get Landmarks by City ID
final class GetLandmarksByCityLoading extends UserState {}
final class GetLandmarksByCitySuccess extends UserState {
  final List<Landmark> landmarks;
  GetLandmarksByCitySuccess({required this.landmarks});
}
final class GetLandmarksByCityFailure extends UserState {
  final String errMessage;
  GetLandmarksByCityFailure({required this.errMessage});
}



//create visit states
final class CreateVisitLoading extends UserState {}
final class CreateVisitSuccess extends UserState {
  final String message;
  CreateVisitSuccess({required this.message});
}
final class CreateVisitFailure extends UserState {
  final String errMessage;
  CreateVisitFailure({required this.errMessage});
}

final class UserLoaded extends UserState {
  final String name;
  final String email;
  final String phoneNumber;
  final String country;
  final String role;

  UserLoaded({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.role,
  });

  UserLoaded copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? country,
    String? role,
  }) {
    return UserLoaded(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      role: role ?? this.role,
    );
  }
}
final class UserInfoUpdated extends UserState {}


