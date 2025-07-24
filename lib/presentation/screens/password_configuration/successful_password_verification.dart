import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/login.dart';
import 'package:maporia/presentation/widgets/clickable_text.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

class SuccessfulPasswordVerification extends StatelessWidget {
  static String routeName = '/successfulPasswordVerification';
  const SuccessfulPasswordVerification({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return CustomScaffold(
      children: [
        TextContainer(
            text: AppText.passwordChangedSuccessfully,
            textAlign: TextAlign.center,
            fontSize: 16
        ),
        SizedBox(height: height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.5,
              height: width * 0.5,
              child: Image.asset(
                AppAssets.right,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        ClickableText(
          title: AppText.signIn,
          size: 16,
          color: AppColors.brown,
          function: (){
            Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false,);
            },
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
