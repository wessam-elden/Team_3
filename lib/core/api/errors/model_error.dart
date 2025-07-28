// import 'package:dio/dio.dart';
// import 'package:maporia/core/api/api_dio/api_keys.dart';
//
// import '../api_dio/api_endpoints.dart';
//
// class ErrorModel {
//   final String status;
//   final String errorMessage;
//
//   ErrorModel({required this.status, required this.errorMessage});
//
//   factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
//     return ErrorModel(
//         status: jsonData[ApiKey.status],
//         errorMessage: jsonData[ApiKey.errorMessage] ?? jsonData['error'] ??
//             'Unknown error occurred',
//     );
//
// }
//
//   factory ErrorModel.fromDioException(DioException e) {
//     if (e.response?.data is Map<String, dynamic>) {
//       return ErrorModel.fromJson(e.response!.data);
//     }
//     return ErrorModel(
//       errorMessage: e.message ?? 'Network error occurred', status: '',
//     );
//   }
//
// }
