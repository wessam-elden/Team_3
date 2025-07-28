import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/cubit/user_state.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/password_configuration/otp.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_Button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/sign_with.dart';
import 'package:maporia/presentation/screens/signup_screen/signup_widgets/signup_form.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

import '../../../models.dart/sign_up_model.dart';

class Signup extends StatelessWidget {
  static String routeName = '/signup';

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  Signup({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;

    return SafeArea(
      child: BlocConsumer<UserCubit,UserState>(
        listener: (BuildContext context, state) {
      if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message), backgroundColor: Colors.green),
        );
        Navigator.pushReplacementNamed(context, Login.routeName);
      } else if (state is SignUpFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errMessage), backgroundColor: Colors.red),
        );
      };
        },
        builder: (BuildContext context, Object? state) {

        return CustomScaffold(
          children: [
            Padding(
              padding: const EdgeInsets.only( bottom: 20,),
              child: TextContainer(
                  text: AppText.signup,
                  fontSize: 28,
              ),
            ),
            SignUpForm(formKey: signupFormKey),
            SizedBox(height: height*0.03,),
            state is SignUpLoading? CircularProgressIndicator(): CustomButton(
              title: AppText.signup,
              formKey: signupFormKey,
              function: () {
          final cubit = context.read<UserCubit>();

          if (signupFormKey.currentState!.validate()) {
          final request = SignUpRequest(
          name: cubit.signUpName.text.trim(),
          email: cubit.signUpEmail.text.trim(),
          password: cubit.signUpPassword.text.trim(),
          );

          cubit.signUp(request);
          }
              },
            ),
            SizedBox(height: height*0.02,),
            Padding(
              padding: const EdgeInsets.only(
                  right: 60, left: 60, bottom: 10, top: 10),
              child: Divider(color: AppColors.brown, thickness: 0.5,),
            ),
            TextContainer(
                text:  AppText.continueWith,
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
                  AppText.alreadyAMember,
                  style: TextStyle(
                      color: AppColors.brownCinnamon
                  ),
                ),
                SizedBox(width: 5,),
                ClickableText(
                    title: AppText.signIn,
                    size: 14,
                    color: AppColors.brown,
                    function: (){Navigator.pushReplacementNamed(context, Login.routeName);},
                    fontWeight: FontWeight.bold
                )
              ],
            ),
          ],
        );

        },
      ),
    );
  }
}
