import 'package:dio/dio.dart';
import '../cache/cache_helper.dart';
import '../core/api/api_dio/api_keys.dart';


extension DioTokenExtension on Dio {
  Future<Response<T>> getWithToken<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    final token = await CacheHelper.getData(key: ApiKey.token);

    print("Token used in getAllCities: $token");


    if (token == null || token is! String) {
      throw Exception("Token not found or invalid.");
    }

    final newOptions = options?.copyWith(
      headers: {
        ...?options.headers,
        'Authorization': 'Bearer $token',
      },
    ) ??
        Options(headers: {
          'Authorization': 'Bearer $token',
        });

    return get<T>(
      path,
      queryParameters: queryParameters,
      options: newOptions,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
