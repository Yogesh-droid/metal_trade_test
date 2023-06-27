part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final String mobNo;
  final String otp;

  LoginSuccessfulState({required this.mobNo, required this.otp});
}

class LoginFailedState extends LoginState {
  final Exception exception;

  LoginFailedState(this.exception);
}
