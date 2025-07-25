import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/home.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/signup.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/login_form.dart';
import 'package:maporia/presentation/widgets/text_container.dart';
import 'package:maporia/presentation/widgets/sign_with.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return CustomScaffold(
      children: [
        TextContainer(
            text: AppText.loginTitle,
            fontSize: 28
        ),
        TextContainer(
            text: AppText.loginSubtitle,
            fontSize: 18
        ),
        SizedBox(height: height * 0.03,),
        LoginForm(formKey: formKey,),
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15, bottom: 30, right: 10, left: 10),
            child: ClickableText(
              title: AppText.forgotPassword,
              textAlign: TextAlign.end,
              size: 15,
              color: AppColors.brownCinnamon,
              fontWeight: FontWeight.w400,
              function: () {
                Navigator.pushNamed(context, ForgotPassword.routeName);
              },
            ),
          ),
        ),
        CustomButton(
          title: AppText.signIn,
          formKey: formKey,
          function: () {
            Navigator.pushReplacementNamed(context, Home.routeName);
          },
        ),
        SizedBox(height: height * 0.03,),
        Padding(
          padding: const EdgeInsets.only(
              right: 60, left: 60, bottom: 10, top: 10),
          child: Divider(color: AppColors.brown, thickness: 0.5,),
        ),
        TextContainer(
            text: AppText.continueWith,
            fontSize: 16,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400
        ),
        SizedBox(height: height * 0.02,),
        SignWith(),
        SizedBox(height: height * 0.03,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppText.needAnAccount,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(width: width*0.01,),
            ClickableText(
                title: AppText.registerNow,
                size: 16,
                color: AppColors.brown,
                function: (){
                  Navigator.pushNamed(context, Signup.routeName);
                },
                fontWeight: FontWeight.bold
            )
          ],
        )
      ],
    );
  }
}
