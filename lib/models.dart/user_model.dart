class UserModel {
  final int id;
  final String name;
  final String email;
  final String gender;
  final int visits;
  final int favorites;
  final String role;
  final String country;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.visits,
    required this.favorites,
    required this.role,
    required this.country,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      visits: json['visits'] ?? 0,
      favorites: json['favorites'] ?? 0,
      role: json['role'] ?? '',
      country: json['country'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
