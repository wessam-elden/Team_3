import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String title;
  final Function function;
  const CustomButton({
    super.key,
    required this.title,
    required this.function,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.06,
      width: MediaQuery.of(context).size.width*0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.brownCinnamon),
        onPressed: (){
          if(formKey != null){
            if(formKey!.currentState?.validate()==true) {
              function();
            }
          }
          else {
            function();
          }
        },
        child: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.ivoryWhite
            ),
          ) ,
      ),
    );
  }
}
