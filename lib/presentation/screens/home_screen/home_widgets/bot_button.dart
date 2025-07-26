import 'package:flutter/material.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/presentation/screens/chatbot_screen/chatbot.dart';


class BotButton extends StatelessWidget {
  final Offset initialOffset;
  final void Function(Offset) onDragEnd;

  const BotButton({
    super.key,
    required this.initialOffset,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: _botAvatar(context),
      childWhenDragging: Container(),
      onDraggableCanceled: (velocity, offset) {
        onDragEnd(offset);
      },
      child: _botAvatar(context),
    );
  }

  Widget _botAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatBotPage()),
        );
      },
      child: const CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage(AppAssets.botIcon),
      ),
    );
  }
}
