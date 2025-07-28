//
// import 'package:dio/dio.dart';
//
// import 'model_error.dart';
//
// class ServerException implements Exception {
//   final ErrorModel errModel;
//
//   ServerException({required this.errModel});
// }
//
// void handleDioExceptions(DioException e) {
//   // Handle HTML responses
//   if (e.response?.data is String &&
//       e.response!.data.toString().contains('<!DOCTYPE html>')) {
//     throw ServerException(
//       errModel: ErrorModel(errorMessage: 'Server error: ${e.response?.statusCode}', status: ''),
//     );
//   }
//
//   // Handle JSON responses
//   if (e.response?.data is Map<String, dynamic>) {
//     throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
//   }
//
//   // Fallback for other cases
//   throw ServerException(
//     errModel: ErrorModel(errorMessage: e.message ?? 'Unknown error', status: ''),
//   );
// }