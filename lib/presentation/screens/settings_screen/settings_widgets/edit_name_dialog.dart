import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class EditNameDialog extends StatelessWidget {
  final String firstName;
  final String lastName;

  const EditNameDialog({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);

    return AlertDialog(
      title: const Text(
        AppText.editName,
        style: TextStyle(color: AppColors.brown),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: firstNameController,
            decoration: _inputDecoration(AppText.firstName),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: lastNameController,
            decoration: _inputDecoration(AppText.lastName),
          ),
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
              'firstName': firstNameController.text,
              'lastName': lastNameController.text,
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
