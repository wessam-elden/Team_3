import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/core/api/api_dio/dio_consumer.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/presentation/screens/home_screen/home.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/onboarding.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/profile_screen/profile.dart';
import 'package:maporia/presentation/screens/settings_screen/settings.dart';
import 'package:maporia/presentation/screens/signup_screen/signup.dart';
import 'presentation/screens/password_configuration/reset_password.dart';


void main() {
  runApp(
      BlocProvider(create: (context)=>UserCubit(),
        child: const Maporia(),)
  ); }

class Maporia extends StatelessWidget {
  const Maporia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Onboarding.routeName,
      routes: {
        Onboarding.routeName: (context) => const Onboarding(),
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),
        Signup.routeName: (context) => Signup(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        ResetPassword.routeName: (context) => ResetPassword(),
        Profile.routeName: (context) => Profile(),
        Settings.routeName: (context) => Settings(),

      },
    );
  }
}
