import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class EditNameDialog extends StatelessWidget {
  final String Name;
  //final String lastName;

  const EditNameDialog({
    super.key,
    required this.Name,
    //required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final NameController = TextEditingController(text: Name);
   // final lastNameController = TextEditingController(text: lastName);

    return AlertDialog(
      title: const Text(
        AppText.editName,
        style: TextStyle(color: AppColors.brown),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: NameController,
            decoration: _inputDecoration(AppText.Name),
          ),
          const SizedBox(height: 10),
          // TextField(
          //   controller: lastNameController,
          //   decoration: _inputDecoration(AppText.lastName),
          // ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppText.cancel, style: TextStyle(color: AppColors.brown)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, {
              'Name': NameController.text,
              //'lastName': lastNameController.text,
            });
          },
          child: const Text(AppText.save, style: TextStyle(color: AppColors.brown)),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.brown),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.brown),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.brown),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
