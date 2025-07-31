
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/dio_withtoken/dio_withtoken.dart';
import 'package:maporia/models.dart/login_model.dart';

import '../cache/cache_helper.dart';
import '../core/api/api_dio/api_endpoints.dart';
import '../core/api/api_dio/api_keys.dart';
import '../models.dart/chatpot_model.dart';
import '../models.dart/createCity_model.dart';
import '../models.dart/landmark_model.dart';
import '../models.dart/profile_model.dart';
import '../models.dart/sign_up_model.dart';
import '../models.dart/visit_model.dart';



class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final Dio dio = Dio();

  TextEditingController logInEmail = TextEditingController();
  TextEditingController logInPassword = TextEditingController();
  GlobalKey<FormState> logInFormKey = GlobalKey();

  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  TextEditingController signUpConfirmPassword = TextEditingController();

  TextEditingController profileNameController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileCountryController = TextEditingController();
  TextEditingController profileRoleController = TextEditingController();
  Map<String, List<Landmark>> landmarksByCity = {};


  Future<void> login(LoginRequest request) async {
    emit(LoginInLoading());
    try {
      final response = await dio.post(
        Endpoints.logIn,
        data: request.toJson(),
        options: Options(
          headers: {
            ApiKey.contentType: ApiKey.applicationJson,
          },
          validateStatus: (_) => true,
        ),
      );

      final statusCode = response.statusCode;
      print('Status code: $statusCode');
      print('Response: ${response.data}');


      if (statusCode == 200) {
        final token = response.data[ApiKey.token];
        final message = response.data[ApiKey.message];

        print("Token received: $token");
        await CacheHelper.removeData(key: ApiKey.token);

        await CacheHelper.saveData(key: ApiKey.token, value: token);
        emit(LoginInSuccess(message: message));
      } else if (statusCode == 400) {
        emit(LoginInFailure(
            errMessage: "Please enter both email and password."));
      } else if (statusCode == 401) {
        emit(LoginInFailure(errMessage: "Email or password is incorrect."));
      } else if (statusCode == 500) {
        emit(LoginInFailure(
            errMessage: "Login failed. Please try again later."));
      } else {
        final msg = response.data[ApiKey.message] ?? "Unexpected error.";
        emit(LoginInFailure(errMessage: msg));
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      print("Dio response: ${e.response?.data}");
      emit(LoginInFailure(
          errMessage: "Network error. Please check your internet or try again later."));
    } catch (e) {
      print("Unexpected error: $e");
      emit(LoginInFailure(errMessage: "Unexpected error occurred."));
    }
  }


  Future<void> signUp(SignUpRequest request) async {
    emit(SignUpLoading());

    try {
      final response = await dio.post(
        Endpoints.signUp,
        data: request.toJson(),
        options: Options(headers: {
          ApiKey.contentType: ApiKey.applicationJson,
        }),
      );
      final signUpResponse = SignUpResponse.fromJson(response.data);

      emit(SignUpSuccess(message: signUpResponse.message));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.response?.data['message'] ?? 'Something went wrong';
      print("Dio error: ${e.message}");

      print('Login error: ${e.response?.data}');
      print('Status code: ${e.response?.statusCode}');

      if (statusCode == 400) {
        emit(SignUpFailure(
            errMessage: "Please fill in all required fields correctly."));
      } else if (statusCode == 409) {
        emit(SignUpFailure(errMessage: "This email is already registered."));
      } else if (statusCode == 500) {
        emit(SignUpFailure(
            errMessage: "Something went wrong. Please try again later."));
      } else {
        emit(SignUpFailure(errMessage: msg));
      }
    }
  }

  Future<void> createCity(String cityName) async {
    emit(CreateCityLoading());

    try {
      final token = await CacheHelper.getData(key: ApiKey.token);
      print("Token: $token");

      if (token == null) {
        emit(CreateCityFailure(errMessage: "User is not logged in."));
        return;
      }


      final response = await dio.post(
        Endpoints.createcity,
        data: {
          ApiKey.name: cityName,
        },
        options: Options(headers: {
          ApiKey.contentType: ApiKey.applicationJson,
          'Authorization': 'Bearer $token',
        }),
      );

      final message = response.data[ApiKey.message];
      final city = City.fromJson(response.data['data']);
      print("City Created: $city");

      emit(CreateCitySuccess(message: message, city: city));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.response?.data[ApiKey.message] ?? 'Something went wrong';
      print("Dio error: ${e.message}");
      print("Error creating city: ${e.response?.data}");

      if (statusCode == 400) {
        emit(CreateCityFailure(errMessage: "Please enter a valid city name."));
      } else if (statusCode == 401 || statusCode == 403) {
        emit(CreateCityFailure(
            errMessage: "Only admins can create cities. Please log in with an admin account."));
      } else {
        emit(CreateCityFailure(errMessage: msg));
      }
    }
  }

  // Get all cities
  Future<void> getAllCities() async {
    emit(GetAllCitiesLoading());
    try {
      final response = await dio.getWithToken(Endpoints.getCities);
      print("Cities response: ${response.data}");

      final data = response.data['data'] as List;
      final cities = data.map((e) => City.fromJson(e)).toList();

      emit(GetAllCitiesSuccess(cities: cities));
    } on DioException catch (e) {
      final msg = e.response?.data[ApiKey.message] ??
          'Failed to load cities. Please try again later.';
      emit(GetAllCitiesFailure(errMessage: msg));
    }
  }


// Create new landmark
  Future<void> createLandmark(CreateLandmarkRequest request) async {
    emit(CreateLandmarkLoading());

    try {
      final token = await CacheHelper.getData(key: ApiKey.token);
      print("Token: $token");

      if (token == null) {
        emit(CreateLandmarkFailure(errMessage: "User is not logged in."));
        return;
      }

      final response = await dio.post(
        Endpoints.createLandmark,
        data: request.toJson(),
        options: Options(headers: {
          ApiKey.contentType: ApiKey.applicationJson,
          'Authorization': 'Bearer $token',
        }),
      );

      final message = response.data[ApiKey.message];
      final landmarkData = response.data['data'];
      final landmark = Landmark.fromJson(landmarkData);

      print("Landmark Created: $landmarkData");

      emit(CreateLandmarkSuccess(
        message: message,
        landmark: landmark,

      )
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.response?.data[ApiKey.message] ?? 'Something went wrong';
      print("Dio error: ${e.message}");
      print("Error creating landmark: ${e.response?.data}");

      if (statusCode == 400) {
        emit(CreateLandmarkFailure(
            errMessage: "Please fill in all required fields."));
      } else if (statusCode == 401 || statusCode == 403) {
        emit(CreateLandmarkFailure(
            errMessage: "You must be an admin to perform this action."));
      } else {
        emit(CreateLandmarkFailure(errMessage: msg));
      }
    }
  }


//get all landmarks
  Future<void> getAllLandmarks() async {
    emit(GetAllLandmarksLoading());
    try {
      print("aaaaaaaaaaavbvvvvvvvvvvvaaaaaaa");
      final response = await dio.getWithToken(Endpoints.getLandmarks);
      print("aaaaaaaaaaaaaaaaaa");
      final data = response.data['data'] as List;
      print("aaaaaaaaaaaaaaaaaa222");
      final landmarks = data.map((e) => Landmark.fromJson(e)).toList();

      emit(GetAllLandmarksSuccess(landmarks: landmarks));
    } on DioException catch (e) {
      print("Error fetching landmarks: ${e.message}");
      final msg = e.response?.data[ApiKey.message] ??
          'Failed to load landmarks. Please try again later.';
      emit(GetAllLandmarksFailure(errMessage: msg));
    }
  }


  //get landmark by City id
  Future<void> getLandmarksByCityId(int cityId) async {
    emit(GetLandmarksByCityLoading());
    try {
      final response = await dio.getWithToken(Endpoints.getLandmarksByCityIdd);
      print("Landmarks by CityId Response: ${response.data}");
      final data = response.data['data'] as List;
      final landmarks = data.map((e) => Landmark.fromJson(e)).toList();

      landmarksByCity[cityId.toString()] = landmarks;

      emit(GetLandmarksByCitySuccess(landmarks: landmarks));
    } on DioException catch (e) {
      final msg = e.response?.data[ApiKey.message] ??
          'Failed to fetch landmarks. Please try again later.';
      emit(GetLandmarksByCityFailure(errMessage: msg));
    }
  }



  // Create visit
  Future<void> createVisit(VisitRequest request) async {
    emit(CreateVisitLoading());

    try {
      final token = await CacheHelper.getData(key: ApiKey.token);
      if (token == null) {
        emit(CreateVisitFailure(
            errMessage: "You must be logged in to record a visit."));
        return;
      }

      final response = await dio.post(
        Endpoints.createVisit,
        data: request.toJson(),
        options: Options(headers: {
          ApiKey.contentType: ApiKey.applicationJson,
          'Authorization': 'Bearer $token',
        }),
      );

      final message = response.data[ApiKey.message];
      emit(CreateVisitSuccess(message: message));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.response?.data[ApiKey.message] ??
          'Could not record visit. Please try again later.';

      if (statusCode == 400) {
        emit(CreateVisitFailure(
            errMessage: "Please fill in all required fields."));
      } else if (statusCode == 401) {
        emit(CreateVisitFailure(
            errMessage: "You must be logged in to record a visit."));
      } else {
        emit(CreateVisitFailure(errMessage: msg));
      }
    }
  }

//get profile
  Future<void> getProfile() async {
    emit(GetProfileLoading());

    try {
      final response = await dio.getWithToken(Endpoints.getProfile);

      final profileResponse = GetProfileResponse.fromJson(response.data);
      final profile = profileResponse.data;

      profileNameController.text = profile.name;
      profileEmailController.text = profile.email;
      profilePhoneController.text = profile.phone_number;
      profileCountryController.text = profile.country;
      profileRoleController.text = profile.role;

      emit(GetProfileSuccess(
        name: profile.name,
        email: profile.email,
        phoneNumber: profile.phone_number,
        country: profile.country,
        role: profile.role,
      ));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      String errorMessage = "Something went wrong. Please try again later.";

      if (statusCode == 400) {
        errorMessage = "Invalid user session. Please log in again.";
      } else if (statusCode == 404) {
        errorMessage = "User account not found.";
      } else if (statusCode == 500) {
        errorMessage = "Something went wrong. Please try again later.";
      } else {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }

      emit(GetProfileFailure(errMessage: errorMessage));
    }
  }

  void updateUserInfo({String? name, String? phone, String? country}) {
    if (name != null) profileNameController.text = name;
    if (phone != null) profilePhoneController.text = phone;
    if (country != null) profileCountryController.text = country;

    emit(UserInfoUpdated());
  }

  Future<void> sendChat (String question) async {
    emit(ChatLoading());

    try {
      final token = await CacheHelper.getData(key: ApiKey.token);

      if (token == null) {
        emit(ChatFailure(errMessage: "You must be logged in."));
        return;
      }

      final response = await dio.post(
        Endpoints.chatpot,
        data: {'question': question},
        options: Options(
          headers: {
            ApiKey.contentType: ApiKey.applicationJson,
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      final chatResponse = ChatResponse.fromJson(data);


      emit(ChatSuccess(
        answer: chatResponse.answer,
        responseTimeSec: chatResponse.responseTimeSec,
      ));
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Something went wrong.';
      emit(ChatFailure(errMessage: msg));
    }
  }


// String userName = "ghada";
// String userPhone = "0123456789";
// String userCountry = "Egypt";
// String userRole = "Tourist";
// String userEmail = "ghada@example.com";
//
// String get name => userName;
// String get phone => userPhone;
// String get country => userCountry;
// String get role => userRole;
// String get email => userEmail;
//
// void updateUserInfo({String? name, String? phone, String? country}) {
//   if (name != null) userName = name;
//   if (phone != null) userPhone = phone;
//   if (country != null) userCountry = country;
//
//   emit(UserInfoUpdated());
// }


}
