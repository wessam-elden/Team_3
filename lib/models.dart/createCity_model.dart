import 'package:maporia/core/api/api_dio/api_keys.dart';

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json[ApiKey.id] is int ? json[ApiKey.id] : int.tryParse(json[ApiKey.id].toString()) ?? 0,

      name: json[ApiKey.name] ?? '', // Use empty string if name is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class CreateCityRequest {
  final String name;

  CreateCityRequest({required this.name});

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}

class CreateCityResponse {
  final bool success;
  final String message;
  final City city;

  CreateCityResponse({
    required this.success,
    required this.message,
    required this.city,
  });

  factory CreateCityResponse.fromJson(Map<String, dynamic> json) {
    return CreateCityResponse(
      success: json[ApiKey.success] ?? false,
      message: json[ApiKey.message],
      city: City.fromJson(json['data']),
    );
  }
}
