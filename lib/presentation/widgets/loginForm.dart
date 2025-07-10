import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({super.key,required this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool isVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppText.enterEmail; // "Please enter your email"
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value.trim().toLowerCase())) {
      return AppText.invalidEmail; // "Invalid email format"
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.enterPassword;
    }return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          //email
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            cursorColor: AppColors.brown,
            cursorErrorColor: AppColors.error,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: AppText.email,
              hintStyle: TextStyle(
                color: AppColors.hintText
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.brown)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.brown)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.error)
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.error)
              ),
            ),
          ),
          SizedBox(height: 20,),
          //password
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: !isVisible,
            cursorColor: AppColors.brown,
            cursorErrorColor: AppColors.error,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              hintText: AppText.password,
              hintStyle: TextStyle(
                  color: AppColors.hintText
              ),
              suffixIcon: InkWell(
                onTap: ()=> setState(() { isVisible = !isVisible;}),
                child: isVisible? Icon(Icons.visibility):Icon(Icons.visibility_off),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.brown)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.brown)
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.error)
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.error)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
