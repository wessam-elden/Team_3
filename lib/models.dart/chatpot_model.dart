class ChatRequest {
  final String question;

  ChatRequest({required this.question});

  Map<String, dynamic> toJson() {
    return {
      'question': question,
    };
  }
}


class ChatResponse {
  final String answer;
  final double responseTimeSec;

  ChatResponse({
    required this.answer,
    required this.responseTimeSec,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      answer: json['answer'] ?? '',
      responseTimeSec: (json['response_time_sec'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

