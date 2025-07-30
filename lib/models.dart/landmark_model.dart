import 'package:maporia/core/api/api_dio/api_keys.dart';

class Landmark {
  final int id;
  final String name;
  final String? description;
  final String location;
  final String? imageUrl;
  final String? openingHours;
  final num? ticketPrice;
  final int cityId;

  Landmark({
    required this.id,
    required this.name,
    this.description,
    required this.location,
    this.imageUrl,
    this.openingHours,
    this.ticketPrice,
    required this.cityId,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: int.tryParse(json[ApiKey.id].toString()) ?? 0,
      name: json[ApiKey.name] ?? '',
      description: json[ApiKey.description],
      location: json[ApiKey.location] ?? '',
      imageUrl: json[ApiKey.imageUrl],
      openingHours: json[ApiKey.openingHours],
      ticketPrice: num.tryParse(json[ApiKey.ticketPrice]?.toString() ?? ''),
      cityId: int.tryParse(json[ApiKey.cityId].toString()) ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.name: name,
      ApiKey.description: description,
      ApiKey.location: location,
      ApiKey.imageUrl: imageUrl,
      ApiKey.openingHours: openingHours,
      ApiKey.ticketPrice: ticketPrice,
      ApiKey.cityId: cityId,
    };
  }
}

class CreateLandmarkRequest {
  final String name;
  final String? description;
  final String location;
  final String? imageUrl;
  final String? openingHours;
  final num? ticketPrice;
  final int cityId;

  CreateLandmarkRequest({
    required this.name,
    this.description,
    required this.location,
    this.imageUrl,
    this.openingHours,
    this.ticketPrice,
    required this.cityId,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.description: description,
      ApiKey.location: location,
      ApiKey.imageUrl: imageUrl,
      ApiKey.openingHours: openingHours,
      ApiKey.ticketPrice: ticketPrice,
      ApiKey.cityId: cityId,
    };
  }
}

class CreateLandmarkResponse {
  final bool success;
  final String message;
  final Landmark landmark;

  CreateLandmarkResponse({
    required this.success,
    required this.message,
    required this.landmark,
  });

  factory CreateLandmarkResponse.fromJson(Map<String, dynamic> json) {
    return CreateLandmarkResponse(
      success: json[ApiKey.success] ?? false,
      message: json[ApiKey.message],
      landmark: Landmark.fromJson(json['data']),
    );
  }
}