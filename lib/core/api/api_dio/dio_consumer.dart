// import 'package:dio/dio.dart';
// import 'dart:convert'; // لإستخدام jsonDecode
// import '../errors/exceptions.dart';
// import 'api_consumer.dart';
// import 'api_endpoints.dart';
// import 'api_interceptor.dart';
//
// class DioConsumer extends ApiConsumer {
//
//   final Dio dio;
//
//   DioConsumer({required this.dio}) {
//     dio.options.baseUrl = Endpoints.baseUrl;
//     dio.interceptors.add(ApiInterceptor());
//     dio.interceptors.add(LogInterceptor(
//       request: true,
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//       responseBody: true,
//       error: true,
//     ));
//   }
//
//   @override
//   Future delete(
//       String path, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         bool isFromData = false,
//       }) async {
//     try {
//       final response = await dio.delete(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return _handleResponse(response);
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }
//
//   @override
//   Future get(String path,
//       {Object? data, Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await dio.get(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return _handleResponse(response);
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }
//
//   @override
//   Future patch(
//       String path, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         bool isFromData = false,
//       }) async {
//     try {
//       final response = await dio.patch(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return _handleResponse(response);
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }
//
//   @override
//   Future post(
//       String path, {
//         dynamic data,
//         Map<String, dynamic>? queryParameters,
//         bool isFromData = false,
//       }) async {
//     try {
//       final response = await dio.post(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return _handleResponse(response);
//     } on DioException catch (e) {
//       handleDioExceptions(e);
//     }
//   }
//   dynamic _handleResponse(Response response) {
//     try {
//       if (response.data is String) {
//         // Check if it's HTML error response
//         if (response.data.toString().contains('<!DOCTYPE html>')) {
//           throw DioException(
//             requestOptions: response.requestOptions,
//             response: response,
//             type: DioExceptionType.badResponse,
//           );
//         }
//         return jsonDecode(response.data);
//       }
//       return response.data;
//     } catch (e) {
//       throw DioException(
//         requestOptions: response.requestOptions,
//         response: response,
//         type: DioExceptionType.badResponse,
//         error: 'Failed to parse response: $e',
//       );
//     }
//   }
//   }