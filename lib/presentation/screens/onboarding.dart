import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/widgets/custom_Button.dart';
import 'package:maporia/presentation/widgets/custom_background.dart';

class Onboarding extends StatelessWidget {
  static String routeName = '/onboarding';
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Text(
                AppText.maporia,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ivoryWhite,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.ivoryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      bottom: 30,
                      right: 15,
                      left: 15,
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          AppText.welcome,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.brownCinnamon,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    title: AppText.startButton,
                    formKey: null,
                    function: () {
                      Navigator.pushReplacementNamed(context, Login.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
