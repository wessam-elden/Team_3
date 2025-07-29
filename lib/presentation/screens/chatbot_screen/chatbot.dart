import 'package:flutter/material.dart';
import 'package:maporia/presentation/screens/chatbot_screen/chatbot_widgets/chat_background.dart';
import 'package:maporia/presentation/screens/chatbot_screen/chatbot_widgets/chat_input_field.dart';
import 'package:maporia/presentation/screens/chatbot_screen/chatbot_widgets/chat_message_bubble.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "text": text});
        _messages.add({"sender": "bot", "text": "📜 $text"});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: const Color(0xFF8C5E3C),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const ChatBackground(),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return ChatMessageBubble(
                      text: msg["text"] ?? "",
                      isUser: msg["sender"] == "user",
                    );
                  },
                ),
              ),
              ChatInputField(controller: _controller, onSend: _sendMessage),
            ],
          ),
        ],
      ),
    );
  }
}
