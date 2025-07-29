import 'package:flutter/material.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';

class EditNameDialog extends StatefulWidget {
  final String currentName;
  final Function(String) onNameChanged;

  const EditNameDialog({
    super.key,
    required this.currentName,
    required this.onNameChanged,
  });

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        AppText.editName,
        style: TextStyle(color: AppColors.brown),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: AppText.enterNewName,
            hintStyle: const TextStyle(color: AppColors.taupeGray),
            focusedBorder: _buildBorder(),
            enabledBorder: _buildBorder(),
          ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppText.invalidName;
              }
              final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
              if (!nameRegex.hasMatch(value.trim())) {
                return AppText.invalidNameForm;
              }
              return null;
            }
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            AppText.cancel,
            style: TextStyle(color: AppColors.brown),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onNameChanged(_controller.text.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            AppText.save,
            style: TextStyle(color: AppColors.brown),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.brown),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
