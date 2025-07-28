
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/core/api/api_dio/api_consumer.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/models.dart/login_model.dart';

import '../cache/cache_helper.dart';
import '../core/api/api_dio/api_endpoints.dart';
import '../core/api/api_dio/api_keys.dart';
import '../models.dart/sign_up_model.dart';



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


  Future<void> login(LoginRequest request) async {
    emit(LoginInLoading());
    try {
      final response = await dio.post(
        Endpoints.logIn,
        data: request.toJson(),
        options: Options(headers: {
          ApiKey.contentType: ApiKey.applicationJson,
        }),
      );

      final token = response.data[ApiKey.token];
      final message = response.data[ApiKey.message];

      await CacheHelper.saveData(key: ApiKey.token, value: token);

      emit(LoginInSuccess(message: message));
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.response?.data[ApiKey.message] ?? 'Something went wrong';
      print('Login error: ${e.response?.data}');
      print('Status code: ${e.response?.statusCode}');

      if (statusCode == 400) {
        emit(LoginInFailure(
            errMessage: "Please enter both email and password."));
      } else if (statusCode == 401) {
        emit(LoginInFailure(errMessage: "Email or password is incorrect."));
      } else if (statusCode == 500) {
        emit(LoginInFailure(
            errMessage: "Login failed. Please try again later."));
      } else {
        emit(LoginInFailure(errMessage: msg));
      }
    }
  }




Future<void> signUp(SignUpRequest request) async {
  emit(SignUpLoading());

  try {
    final response = await dio.post(
      Endpoints.signUp,
      data: request.toJson(),
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );
    final signUpResponse = SignUpResponse.fromJson(response.data);

    emit(SignUpSuccess(message: signUpResponse.message));
  } on DioException catch (e) {

    final statusCode = e.response?.statusCode;
    final msg = e.response?.data['message'] ?? 'Something went wrong';
    print('Login error: ${e.response?.data}');
    print('Status code: ${e.response?.statusCode}');

    if (statusCode == 400) {
      emit(SignUpFailure(errMessage: "Please fill in all required fields correctly."));
    } else if (statusCode == 409) {
      emit(SignUpFailure(errMessage: "This email is already registered."));
    } else if (statusCode == 500) {
      emit(SignUpFailure(errMessage: "Something went wrong. Please try again later."));
    } else {
      emit(SignUpFailure(errMessage: msg));
    }
  }
}
}

