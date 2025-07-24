import 'package:flutter/material.dart';

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
          //الخلفية
          Positioned.fill(
            child: Image.asset('assets/images/papyrus.jpg', fit: BoxFit.cover),
          ),

          //  عشان المحتوى ييجي فوق الخلفية
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg["sender"] == "user";
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
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
                          border: Border.all(
                            color: Colors.brown.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          msg["text"] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isUser ? Colors.brown.shade900 : Colors.black,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.transparent, //  شفاف علشان الخلفية تبان
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                          // ignore: deprecated_member_use
                          const Color.fromARGB(
                            255,
                            229,
                            177,
                            126,
                            // ignore: deprecated_member_use
                          ).withOpacity(0.85),
                          hintText: 'Ask anything...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF8C5E3C),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: const Color(0xFF8C5E3C),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
