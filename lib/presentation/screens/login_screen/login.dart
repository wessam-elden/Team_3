import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/core/api/api_dio/api_keys.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/presentation/screens/home_screen/home.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/signup_screen/signup.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/screens/login_screen/login_widgets/login_form.dart';
import 'package:maporia/presentation/widgets/text_container.dart';
import 'package:maporia/presentation/widgets/sign_with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models.dart/login_model.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SafeArea(
      child: BlocConsumer<UserCubit,UserState>(
        listener: (BuildContext context, state) {
          if(state is LoginInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<UserCubit>(context),
                  child: const Home(),
                ),
              ),
            );

          } else if (state is LoginInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
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
            LoginForm(formKey: cubit.logInFormKey),
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
            state is LoginInLoading? const Center(child: CircularProgressIndicator())
                :CustomButton(
              title: AppText.signIn,
              formKey: cubit.logInFormKey,
              function: () {
               // final cubit = context.read<UserCubit>();
                if (cubit.logInFormKey.currentState?.validate()==true) {
                  final request = LoginRequest(
                    email: cubit.logInEmail.text.trim(),
                    password: cubit.logInPassword.text.trim(),
                  );

                  cubit.login(request);


                }
              },
                ),
            SizedBox(height: height * 0.02,),
            Padding(
              padding: const EdgeInsets.only(right: 60, left: 60, bottom: 10, top: 10),
                child: Divider(color: AppColors.brown, thickness: 0.5,),
            ),
            SizedBox(height: height * 0.015,),
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
                    size: 15,
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
        },
      ),
    );
  }
}
