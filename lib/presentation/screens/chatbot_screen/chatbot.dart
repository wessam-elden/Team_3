import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maporia/cubit/user_cubit.dart';
import 'package:maporia/cubit/user_state.dart';
import 'chatbot_widgets/chat_background.dart';
import 'chatbot_widgets/chat_input_field.dart';
import 'chatbot_widgets/chat_message_bubble.dart';

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
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
    });

    context.read<UserCubit>().sendChat(text);
    _controller.clear();
  }

  void _handleBotResponse(String answer) {
    setState(() {
      _messages.add({"sender": "bot", "text": answer});
    });
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
                child: BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is ChatSuccess) {
                      _handleBotResponse(state.answer);
                    } else if (state is ChatFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return ChatMessageBubble(
                          text: msg["text"] ?? "",
                          isUser: msg["sender"] == "user",
                        );
                      },
                    );
                  },
                ),
              ),
              if (context.watch<UserCubit>().state is ChatLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ChatInputField(controller: _controller, onSend: _sendMessage),
            ],
          ),
        ],
      ),
    );
  }
}
