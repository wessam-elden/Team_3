import '../core/api/api_dio/api_keys.dart';

class VisitRequest {
  final int cityId;
  final int landmarkId;
  final String visitDate;
  final int? rating;
  final String? opinion;
  final bool? isfavorite;

  VisitRequest({
    required this.cityId,
    required this.landmarkId,
    required this.visitDate,
    this.rating,
    this.opinion,
    this.isfavorite,
  });

  Map<String, dynamic> toJson() => {
    ApiKey.cityId: cityId,
    ApiKey.landmarkId: landmarkId,
    ApiKey.visitDate: visitDate,
    if (rating != null) ApiKey.rating: rating,
    if (opinion != null) ApiKey.opinion: opinion,
    if (isfavorite != null) ApiKey.isfavorite: isfavorite,
  };
}
class VisitResponse {
  final bool success;
  final String message;

  VisitResponse({
    required this.success,
    required this.message,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) {
    return VisitResponse(
      success: json[ApiKey.success] ?? false,
      message: json[ApiKey.message] ?? '',
    );
  }
}
