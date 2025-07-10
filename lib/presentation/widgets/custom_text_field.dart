import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function validator;
  final Function onChanged;
  final String hintText;
  final bool obscureText;
  final String? helperText;
  final TextStyle? helperStyle;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.hintText,
    required this.obscureText,
    required this.helperText,
    required this.helperStyle,
    required this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) => validator(value),
      onChanged: (value) => onChanged(value),
      cursorColor: AppColors.brown,
      style: const TextStyle(color: AppColors.brown),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintText),
        errorStyle: const TextStyle(color: AppColors.error),
        helperText: helperText,
        helperStyle: helperStyle,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.brown),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.brown),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
