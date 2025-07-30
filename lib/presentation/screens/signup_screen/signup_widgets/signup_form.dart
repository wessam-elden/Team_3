import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/widgets/custom_text_field.dart';

import '../../../../cubit/user_cubit.dart';
import '../../../../cubit/user_state.dart';
import '../../../../models.dart/sign_up_model.dart';

class SignUpForm extends StatefulWidget {
//final GlobalKey<FormState> formKey;

  const SignUpForm({super.key,});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return Form(
      key: cubit.signUpFormKey,
      child: Column(
        children: [
          // Full name
          CustomTextField(
            controller: cubit.signUpName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.required;
              }
              if (!RegExp(r'^[A-Za-z]+( [A-Za-z]+)*$').hasMatch(value)) {
                return AppText.notValid;
              }
              return null;
            },
            onChanged: (_) {},
            hintText: AppText.name,
            obscureText: false,
            helperText: null,
            helperStyle: null,
            suffixIcon: null,
          ),
          const SizedBox(height: 15),

          // Email
          CustomTextField(
            controller: cubit.signUpEmail,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.emailValidator1;
              } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                  .hasMatch(value)) {
                return AppText.emailValidator2;
              }
              return null;
            },
            onChanged: (value) {
              cubit.signUpEmail.value = TextEditingValue(
                text: value.toLowerCase().trim(),
                selection: TextSelection.collapsed(offset: value.length),
              );
            },
            hintText: AppText.email,
            obscureText: false,
            helperText: null,
            helperStyle: null,
            suffixIcon: null,
          ),
          const SizedBox(height: 15),

          // Password
          CustomTextField(
            controller: cubit.signUpPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.enterPassword;
              }
              if (value.length < 8 || value.length > 20) {
                return AppText.passwordValidator3;
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return AppText.passwordValidation1;
              }
              if (!RegExp(r'[a-z]').hasMatch(value)) {
                return AppText.passwordValidation2;
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return AppText.passwordValidation3;
              }
              if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return AppText.passwordValidation4;
              }
              return null;
            },
            onChanged: (_) {},
            hintText: AppText.password,
            obscureText: !isPasswordVisible,
            helperText: AppText.passwordHintText,
            helperStyle: const TextStyle(color: AppColors.hintText),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Confirm Password
          CustomTextField(
            controller: cubit.signUpConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.enterPassword;
              }
              if (value != cubit.signUpPassword.text) {
                return AppText.passwordsDoNotMatch;
              }
              return null;
            },
            onChanged: (_) {},
            hintText: AppText.confirmPassword,
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              child: Icon(
                isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          SizedBox(height: 20,),
         // state is SignUpLoading? CircularProgressIndicator():
          SizedBox(
            height: MediaQuery.of(context).size.height*0.06,
            width: MediaQuery.of(context).size.width*0.7,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.brownCinnamon),
              onPressed: (){

                if(cubit.signUpFormKey.currentState?.validate()==true) {
                  final cubit = context.read<UserCubit>();

                  if (cubit.signUpFormKey.currentState!.validate()) {
                    final request = SignUpRequest(
                      name: cubit.signUpName.text.trim(),
                      email: cubit.signUpEmail.text.trim(),
                      password: cubit.signUpPassword.text.trim(),
                    );

                    cubit.signUp(request);
                  }

                }
              },
              child: Text(
                AppText.signup,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.ivoryWhite
                ),
              ) ,
            ),
          ),
        ],
      ),
    );
  }
}
