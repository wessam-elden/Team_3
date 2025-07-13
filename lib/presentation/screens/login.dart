import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/home.dart';
import 'package:maporia/presentation/screens/signup.dart';
import 'package:maporia/presentation/widgets/clickableText.dart';
import 'package:maporia/presentation/widgets/custom_button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/login_form.dart';
import 'package:maporia/presentation/widgets/signWith.dart';

class Login extends StatelessWidget {
  static String routeName = '/login';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppText.loginTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brownCinnamon,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  AppText.loginSubtitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.brownCinnamon,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            LoginForm(formKey: formKey,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 20,right: 10,left: 10),
                  child: ClickableText(
                    title: AppText.forgotPassword,
                    size: 15,
                    color: AppColors.brownCinnamon,
                    fontWeight: FontWeight.w400,
                    function: (){} ,
                  ),
                ),
              ],
            ),
            CustomButton(
              title: AppText.signIn,
              formKey:formKey,
              function: (){
                Navigator.pushReplacementNamed(context, Home.routeName);
              },
            ),
            SizedBox(height: 20,),
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
                      return Navigator.pushNamed(context, Signup.routeName);
                    }
                )
              ],
            ),
            SizedBox(height: 20,),
            SignWith(),
          ],
        ),
    );
  }
}
