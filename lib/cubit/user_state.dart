class UserState {}

final class UserInitial extends UserState {}
final class LoginInSuccess extends UserState {
  final String message;

  LoginInSuccess({required this.message});
}

final class LoginInLoading extends UserState {}
final class LoginInFailure extends UserState {
  final String errMessage;
  LoginInFailure({required this.errMessage});
}



final class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}
final class SignUpLoading extends UserState {}
final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}


