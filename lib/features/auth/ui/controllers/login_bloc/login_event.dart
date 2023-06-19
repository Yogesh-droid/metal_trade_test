part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class GetOtpEvent extends LoginEvent {
  final String mobNo;

  GetOtpEvent({required this.mobNo});
}
