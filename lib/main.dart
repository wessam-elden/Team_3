import 'package:flutter/material.dart';
import 'package:maporia/presentation/screens/home.dart';
import 'package:maporia/presentation/screens/login.dart';
import 'package:maporia/presentation/screens/onboarding.dart';
import 'package:maporia/presentation/screens/signup.dart';

void main() {
  runApp(const Maporia ());
}
class Maporia extends StatelessWidget {
  const Maporia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Signup.routeName,
      routes: {
        Onboarding.routeName : (context)=> const Onboarding(),
        Login.routeName : (context)=> Login(),
        Home.routeName : (context)=> Home(),
        Signup.routeName : (context)=> Signup(),
      },
    );
  }
}
