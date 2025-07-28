//
// import 'package:dio/dio.dart';
//
// import '../../../cache/cache_helper.dart';
// import 'api_keys.dart';
//
// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers[ApiKey.token] =
//     CacheHelper.getData(key: ApiKey.token) != null
//         ? 'Bearer  ${CacheHelper.getData(key: ApiKey.token)}'
//         : null;
//     super.onRequest(options, handler);
//   }
// }
