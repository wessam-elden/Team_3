class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final bool isVerified;
  final String country;
  final String phone_number;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.country,
    required this.phone_number,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isVerified: json['isVerified'] ?? false,
      country: json['country'] ?? '',
      phone_number: json['phone_number'] ?? '',
    );
  }
}

class GetProfileResponse {
  final String message;
  final ProfileModel data;

  GetProfileResponse({
    required this.message,
    required this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      message: json['message'] ?? '',
      data: ProfileModel.fromJson(json['data'] ?? {}),
    );
  }
}

