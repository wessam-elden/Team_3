import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessageBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color:
              isUser
                  // ignore: deprecated_member_use
                  ? const Color(0xFFFFF8DC).withOpacity(0.85)
                  // ignore: deprecated_member_use
                  : const Color(0xFFDAA520).withOpacity(0.85),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
          border: Border.all(color: Colors.brown.shade300, width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isUser ? Colors.brown.shade900 : Colors.black,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
