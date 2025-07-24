import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const TextContainer({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: AppColors.brownCinnamon,
        ),
        softWrap: true,
      ),
    );
  }
}
