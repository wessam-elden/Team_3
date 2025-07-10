import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login.dart';
import 'package:maporia/presentation/widgets/clickableText.dart';
import 'package:maporia/presentation/widgets/custom_Button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/signWith.dart';
import 'package:maporia/presentation/widgets/signup_form.dart';

class Signup extends StatelessWidget {
  static String routeName = '/signup';
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        widget: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8,left: 8, bottom: 10),
                    child: Text(
                      AppText.signup,
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.brownCinnamon,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              SignUpForm(formKey: signupFormKey),
              SizedBox(height: 20,),
              CustomButton(
                  title: AppText.signup,
                  function: ()=>Navigator.pushReplacementNamed(context, Login.routeName),
                  formKey: signupFormKey,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppText.signWith,
                    style: TextStyle(
                        color: AppColors.brownCinnamon
                    ),
                  ),
                  SizedBox(width: 5,),
                  ClickableText(
                      title: AppText.registerNow,
                      size: 14,
                      color: AppColors.brown,
                      fontWeight: FontWeight.bold,
                      function: (){
                        //return Navigator.pushReplacementNamed(context, routeName);
                      }
                  )
                ],
              ),
              SizedBox(height: 20,),
              SignWith(),
            ],
          ),
        ),
    );
  }
}
