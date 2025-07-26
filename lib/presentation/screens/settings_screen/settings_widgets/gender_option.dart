import 'package:flutter/material.dart';

class GenderOption extends StatelessWidget {
  final String gender;
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderOption({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gender),
      leading: Radio<String>(
        value: gender,
        groupValue: selectedGender,
        onChanged: onChanged,
      ),
    );
  }
}
