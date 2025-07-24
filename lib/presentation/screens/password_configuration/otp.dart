import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/password_configuration/forgot_password.dart';
import 'package:maporia/presentation/screens/password_configuration/reset_password.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/text_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP extends StatefulWidget {
  static String routeName = '/otp';
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String enteredCode = "";
  final String correctCode = "1234";
  String? errorMessage;

  void verifyCode() {
    if (enteredCode.isEmpty) {
      setState(() => errorMessage = AppText.error1);
      return;
    }

    if (enteredCode == correctCode) {
      Navigator.pushReplacementNamed(context, ResetPassword.routeName);
    } else {
      setState(() => errorMessage = AppText.error2);
    }
  }

  void resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppText.snackBarMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomScaffold(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextContainer(
            textAlign: TextAlign.center,
            text: AppText.otpVerification,
            fontSize: 28,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PinCodeTextField(
            appContext: context,
            length: 4,
            enableActiveFill: true,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                enteredCode = value;
                errorMessage = null;
              });
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
              fieldHeight: 50,
              fieldWidth: 50,
              inactiveColor: AppColors.hintText,
              inactiveFillColor: Colors.transparent,
              activeColor: AppColors.hintText,
              activeFillColor: Colors.transparent,
              selectedColor: AppColors.hintText,
              selectedFillColor: AppColors.hintText,
            ),
            cursorColor: AppColors.brown,
            textStyle: const TextStyle(
              color: AppColors.brown,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(
            errorMessage!,
            style: const TextStyle(color: AppColors.error, fontSize: 15),
          ),
        ],
        SizedBox(height: size.height * 0.03),
        SizedBox(
          width: size.width * 0.6,
          child: ElevatedButton(
            onPressed: verifyCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brown,
            ),
            child: Text(
              AppText.verify,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.035),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClickableText(
              title: AppText.editEmail,
              size: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.brown,
              function: () => Navigator.pushReplacementNamed(context, ForgotPassword.routeName),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: resendCode,
              child: Text(
                AppText.resend,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.brownCinnamon,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
