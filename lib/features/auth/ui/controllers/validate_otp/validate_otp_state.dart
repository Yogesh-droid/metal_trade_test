part of 'validate_otp_bloc.dart';

@immutable
abstract class ValidateOtpState {}

class ValidateOtpInitial extends ValidateOtpState {}

class ValidateOtpSuccess extends ValidateOtpInitial {
  final String token;

  ValidateOtpSuccess({required this.token});
}

class ValidateOtpFailed extends ValidateOtpState {
  final Exception exception;

  ValidateOtpFailed({required this.exception});
}
