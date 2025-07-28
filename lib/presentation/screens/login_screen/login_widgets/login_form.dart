import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

import '../../../../cubit/user_cubit.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({super.key, required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isVisible = false;


  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.enterEmail; // "Please enter your email"
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value.trim().toLowerCase())) {
      return AppText.invalidEmail; // "Invalid email format"
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.enterPassword;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          //email
          TextFormField(
            controller: cubit.logInEmail,
            validator: _validateEmail,
            cursorColor: AppColors.brown,
            cursorErrorColor: AppColors.red,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: AppText.email,
              hintStyle: TextStyle(color: AppColors.hintText),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.brown),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.brown),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.red),
              ),
            ),
          ),
          SizedBox(height: 20),
          //password
          TextFormField(
            controller: cubit.logInPassword,
            validator: _validatePassword,
            obscureText: !isVisible,
            cursorColor: AppColors.brown,
            cursorErrorColor: AppColors.red,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: AppText.password,
              hintStyle: TextStyle(color: AppColors.hintText),
              suffixIcon: InkWell(
                onTap:
                    () => setState(() {
                      isVisible = !isVisible;
                    }),
                child:
                    isVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.brown),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.brown),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
