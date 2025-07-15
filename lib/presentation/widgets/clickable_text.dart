import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final Function function;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const ClickableText({
    super.key,
    required this.title,
    required this.size,
    required this.color,
    required this.function,
    required this.fontWeight,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
        ),
        softWrap: true,
      ),
    );
  }
}
