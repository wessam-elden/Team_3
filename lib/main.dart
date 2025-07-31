import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maporia/presentation/screens/createcity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/presentation/screens/home_screen/home.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/onboarding.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/password_configuration/reset_password.dart';
import 'package:maporia/presentation/screens/password_configuration/successful_mission.dart';
import 'package:maporia/presentation/screens/profile_screen/profile.dart';
import 'package:maporia/presentation/screens/settings_screen/settings.dart';
import 'package:maporia/presentation/screens/signup_screen/signup.dart';

import 'cache/cache_helper.dart';
void main(){
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  CacheHelper.init();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(),
      child: const MaporiaApp(),
    ),
  );
}

class MaporiaApp extends StatefulWidget {
  const MaporiaApp({super.key});


  @override
  State<MaporiaApp> createState() => _MaporiaAppState();
}

class _MaporiaAppState extends State<MaporiaApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.routeName,
      routes: {
        Onboarding.routeName: (context) => const Onboarding(),
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),
        Signup.routeName: (context) => Signup(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        ResetPassword.routeName: (context) => ResetPassword(),
        Profile.routeName: (context) => Profile(),
        Settings.routeName: (context) => Settings(),
        CreateCity.routeName: (context) => const CreateCity(),

      },
    );
  }
}
