class SignUpRequest {
  final String name;
  final String email;
  final String password;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}


class SignUpResponse {
  final String message;

  SignUpResponse({required this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message'],
    );
  }
}
