part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {}

class LogoutUserProfileEvent extends ProfileEvent {}

class DeleteAccount extends ProfileEvent {
  final String phoneNo;

  DeleteAccount(this.phoneNo);
}
