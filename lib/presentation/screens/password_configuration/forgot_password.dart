import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login_screen/login.dart';
import 'package:maporia/presentation/screens/password_configuration/otp.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_Button.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/custom_text_field.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

class ForgotPassword extends StatelessWidget {
  static String routeName = '/forgotPassword';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  ForgotPassword({super.key});


  @override

  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return CustomScaffold(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextContainer(
            text: AppText.forgotPassword,
            fontSize: 28
        ),
      ),
      Form(
        key: _formKey,
        child: CustomTextField(
            controller: _emailController,
            validator:  (value) {
             if (value == null || value.isEmpty) {
               return AppText.emailValidator1;
             } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
               return AppText.emailValidator2;
             }
             return null;
             },
            onChanged: (value) {
              _emailController.value = TextEditingValue(
                text: value.toLowerCase().trim(),
                selection: TextSelection.collapsed(offset: value.length),);
              },
            hintText: AppText.email,
        )
      ),
      SizedBox(height: height*0.035),
      CustomButton(
          title: AppText.send,
          function:()=>Navigator.pushNamed(context,OTP.routeName),
          formKey: _formKey
      ),
      SizedBox(height: height*0.04),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppText.rememberedIt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(width: width*0.01,),
          ClickableText(
              title: AppText.registerNow,
              size: 15,
              color: AppColors.brown,
              function: (){ Navigator.pushReplacementNamed(context, Login.routeName);},
              fontWeight: FontWeight.bold
          )
        ],
      )
    ],
    );
  }
}


