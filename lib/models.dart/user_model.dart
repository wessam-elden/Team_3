class UserModel {
  final String name;
  final String email;
  final String gender;
  final int visits;
  final int favorites;

  UserModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.visits,
    required this.favorites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      visits: json['visits'] ?? 0,
      favorites: json['favorites'] ?? 0,
    );
  }
}
