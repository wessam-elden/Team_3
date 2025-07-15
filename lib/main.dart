import 'package:flutter/material.dart';
import 'package:maporia/presentation/screens/home.dart';
import 'package:maporia/presentation/screens/login.dart';
import 'package:maporia/presentation/screens/onboarding.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/password_configuration/successful_password_verification.dart';
import 'package:maporia/presentation/screens/signup.dart';

import 'presentation/screens/password_configuration/otp.dart';
import 'presentation/screens/password_configuration/reset_password.dart';

void main() {
  runApp(
    const Maporia(),
  );
}

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
        OTP.routeName: (context) => OTP(),
        ResetPassword.routeName: (context) => ResetPassword(),
        SuccessfulPasswordVerification.routeName: (context) => SuccessfulPasswordVerification(),
      },
    );
  }
}
