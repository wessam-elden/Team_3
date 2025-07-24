import 'package:flutter/material.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/presentation/widgets/custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({super.key, required this.formKey});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          //name
          Row(
            children: [
              //first name
              Expanded(
                child: CustomTextField(
                  controller: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppText.required;
                    }
                    if (!RegExp(r'^[A-Za-z]+(-[A-Za-z]+)?$').hasMatch(value)) {
                      return AppText.notValid;
                    }
                    return null;
                  },
                  onChanged: () {},
                  hintText: AppText.firstName,
                  obscureText: false,
                  helperText: null,
                  helperStyle: null,
                  suffixIcon: null,
                ),
              ),
              const SizedBox(width: 10),
              //last name
              Expanded(
                child: CustomTextField(
                  controller: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppText.required;
                    }
                    if (!RegExp(r'^[A-Za-z]+( [A-Za-z]+)*$').hasMatch(value)) {
                      return AppText.notValid;
                    }
                    return null;
                  },
                  onChanged: () {},
                  hintText: AppText.lastName,
                  obscureText: false,
                  helperText: null,
                  helperStyle: null,
                  suffixIcon: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          //email
          CustomTextField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.emailValidator1;
              } else if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return AppText.emailValidator2;
              }
              return null;
            },
            onChanged: (value) {
              _emailController.value = TextEditingValue(
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
            controller: _passwordController,
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
            onChanged: () {},
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
            controller: _confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppText.enterPassword;
              }
              if (value != _passwordController.text) {
                return AppText.passwordsDoNotMatch;
              }
              return null;
            },
            onChanged: () {},
            hintText: AppText.confirmPassword,
            obscureText: !isConfirmPasswordVisible,
            helperText: null,
            helperStyle: null,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              child: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
