// import '../../models.dart/login_model.dart';
// import '../../models.dart/sign_up_model.dart';
// import '../api/api_dio/api_consumer.dart';
//
// class UserRepository {
//   final ApiConsumer api;
//
//   UserRepository(this.api);
//
//   Future<LoginResponse> login(LoginRequest req) async {
//     final res = await api.post('auth/login', data: req.toJson());
//     return LoginResponse.fromJson(res);
//   }
//
//   Future<SignUpResponse> signUp(SignUpRequest req) async {
//     final res = await api.post('auth/signup', data: req.toJson());
//     return SignUpResponse.fromJson(res);
//   }
// }
