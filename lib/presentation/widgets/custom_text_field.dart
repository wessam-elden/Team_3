import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final void Function(String) onChanged;
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
    this.obscureText = false,
    this.helperText,
    this.helperStyle,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      cursorColor: AppColors.brown,
      style: const TextStyle(color: AppColors.brown),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintText),
        errorStyle: const TextStyle(color: AppColors.red),
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
          borderSide: const BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
