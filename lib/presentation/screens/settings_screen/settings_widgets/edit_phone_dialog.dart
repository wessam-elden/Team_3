import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';

class EditPhoneDialog extends StatefulWidget {
  final String currentPhone;

  const EditPhoneDialog({super.key, required this.currentPhone});

  @override
  State<EditPhoneDialog> createState() => _EditPhoneDialogState();
}

class _EditPhoneDialogState extends State<EditPhoneDialog> {
  late String updatedPhone;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    updatedPhone = widget.currentPhone;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        AppText.editPhone,
        style: TextStyle(color: AppColors.brown),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: widget.currentPhone.isNotEmpty ? widget.currentPhone : null,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            enabledBorder: buildOutlineInputBorder(AppColors.brown),
            focusedBorder: buildOutlineInputBorder(AppColors.brown),
            errorBorder: buildOutlineInputBorder(AppColors.red),
            hintText: AppText.enterPhoneNumber,
            hintStyle: const TextStyle(color: AppColors.taupeGray),
          ),
          onChanged: (value) => updatedPhone = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppText.enterYourPhone;
            }
            // Match Egyptian phone numbers like 01234567890
            final phoneRegex = RegExp(r'^01[0-9]{9}$');
            if (!phoneRegex.hasMatch(value)) {
              return AppText.invalidPhoneNumber;
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppText.cancel, style: TextStyle(color: AppColors.brown)),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<UserCubit>().updateUserInfo(phone: updatedPhone);
              Navigator.pop(context);
            }
          },
          child: const Text(AppText.save, style: TextStyle(color: AppColors.brown)),
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
