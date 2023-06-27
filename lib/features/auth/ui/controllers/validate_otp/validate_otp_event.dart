part of 'validate_otp_bloc.dart';

@immutable
abstract class ValidateOtpEvent {}

class GetValidateOtpEvent extends ValidateOtpEvent {
  final String phoneNo;
  final String otp;

  GetValidateOtpEvent({required this.phoneNo, required this.otp});
}
