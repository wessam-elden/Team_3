import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class EditNameDialog extends StatelessWidget {
  final String name;

  const EditNameDialog({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);

    return AlertDialog(
      title: const Text(
        AppText.editName,
        style: TextStyle(color: AppColors.brown),
      ),
      content: TextField(
        controller: nameController,
        decoration: _inputDecoration(AppText.name),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppText.cancel, style: TextStyle(color: AppColors.brown)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, nameController.text);
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
