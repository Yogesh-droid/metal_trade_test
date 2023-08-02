part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class GetOtpEvent extends LoginEvent {
  final String mobNo;
  final String via;

  GetOtpEvent({required this.via, required this.mobNo});
}
