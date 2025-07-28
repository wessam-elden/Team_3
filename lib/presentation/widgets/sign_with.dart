import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class SignWith extends StatelessWidget {
  const SignWith({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.brown),
            ),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.google,
                    width: screenWidth * 0.07,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      AppText.continueWithGoogle,
                      style: const TextStyle(
                        color: AppColors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
