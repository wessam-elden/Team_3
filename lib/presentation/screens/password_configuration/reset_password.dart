import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/password_configuration/successful_password_verification.dart';
import 'package:maporia/presentation/widgets/custom_Button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/custom_text_field.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

class ResetPassword extends StatefulWidget {
  static String routeName = '/resetPassword';
  final bool needCurrentPassword;
  const ResetPassword({super.key, this.needCurrentPassword = false});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _currentPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isCurrentPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  Widget _buildPasswordField({
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? helperText,
    TextStyle? helperStyle,
  }) {
    return CustomTextField(
      controller: controller,
      obscureText: !obscure,
      validator: validator,
      helperText: helperText,
      helperStyle: helperStyle,
      onChanged: (_) {},
      hintText: hint,
      suffixIcon: IconButton(
        icon: Icon(
          obscure ? Icons.visibility : Icons.visibility_off,
          color: AppColors.hintText,
        ),
        onPressed: toggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;

    return CustomScaffold(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextContainer(
              text: AppText.resetPassword,
              textAlign: TextAlign.center,
              fontSize: 28
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.needCurrentPassword)
                Column(
                  children: [
                    //current password
                    _buildPasswordField(
                      hint: AppText.currentPassword,
                      obscure: isCurrentPasswordVisible,
                      toggle: () => setState(() {
                        isCurrentPasswordVisible = !isCurrentPasswordVisible;
                      }),
                      controller: _currentPasswordController,
                      validator: (value) => (value == null || value.isEmpty)
                          ? AppText.setCurrentPassword
                          : null,
                    ),
                    SizedBox(height: height*0.02),
                  ],
                ),
              //new password
              _buildPasswordField(
                hint: AppText.password,
                obscure: isPasswordVisible,
                toggle: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) return AppText.enterPassword;
                  if (value.length < 8 || value.length > 20) return AppText.passwordValidator3;
                  if (!RegExp(r'[A-Z]').hasMatch(value)) return AppText.passwordValidation1;
                  if (!RegExp(r'[a-z]').hasMatch(value)) return AppText.passwordValidation2;
                  if (!RegExp(r'[0-9]').hasMatch(value)) return AppText.passwordValidation3;
                  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) return AppText.passwordValidation4;
                  return null;
                },
                helperText: AppText.passwordHintText,
                helperStyle:  const TextStyle(color: AppColors.hintText,),
              ),
              SizedBox(height: height*0.02),
              //confirm password
              _buildPasswordField(
                hint: AppText.confirmPassword,
                obscure: isConfirmPasswordVisible,
                toggle: () => setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                }),
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) return AppText.enterPassword;
                  if (value != _passwordController.text) return AppText.passwordsDoNotMatch;
                  return null;
                },
              ),

              SizedBox(height: height*0.03),

              CustomButton(
                  title: AppText.reset,
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SuccessfulPasswordVerification.routeName,
                            (route) => false,
                      );
                    }
                  },
                  formKey: _formKey
              ),
            ],
          ),
        ),
      ],
    );
  }
}
