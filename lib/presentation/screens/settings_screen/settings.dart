import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/constants/app_text.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/settings_section.dart';
import 'package:maporia/presentation/screens/settings_screen/settings_widgets/edit_name_dialog.dart';
import 'package:maporia/presentation/widgets/custom_scaffold.dart';
import 'package:maporia/presentation/widgets/text_container.dart';

class Settings extends StatelessWidget {
  static String routeName = '/settings';
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserCubit>();

    return CustomScaffold(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20, left: 10),
          child: TextContainer(
            text: AppText.settings,
            fontSize: 28,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SettingsSection(
            name: cubit.userName,
            onEditName: () => _editName(context, cubit.userName),
          ),
        ),
      ],
    );
  }

  void _editName(BuildContext context, String currentName) {
    showDialog(
      context: context,
      builder: (_) => EditNameDialog(
        currentName: currentName,
        onNameChanged: (newName) {
          context.read<UserCubit>().updateUserInfo(name: newName);
        },
      ),
    );
  }
}
