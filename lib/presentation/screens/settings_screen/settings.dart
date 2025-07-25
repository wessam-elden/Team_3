import 'package:flutter/material.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/edit_name_dialog.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/settings_section.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

class Settings extends StatefulWidget {
  static String routeName = '/settings';
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //will be changed according to the user's names
  String firstName = "Ghada";
  String lastName = "Abou-El-Fadl";

  void _editName() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => EditNameDialog(
        firstName: firstName,
        lastName: lastName,
      ),
    );

    if (result != null) {
      setState(() {
        firstName = result['firstName']!;
        lastName = result['lastName']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20, left: 10),
          child: TextContainer(
            text: AppText.settings,
            fontSize: 28,
          ),
        ),
        SettingsSection(
          firstName: firstName,
          lastName: lastName,
          onEditName: _editName,
        ),
      ],
    );
  }
}
