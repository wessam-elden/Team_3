import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'custom_background.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> children;
  const CustomScaffold({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomBackground(),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: AppColors.ivoryWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 30, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
