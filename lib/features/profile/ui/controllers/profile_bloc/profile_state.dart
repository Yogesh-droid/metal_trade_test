part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final ProfileEntity profileEntity;

  ProfileSuccessState({required this.profileEntity});
}

class ProfileFailed extends ProfileState {
  final Exception exception;

  ProfileFailed(this.exception);
}

class ProfileLoggedOut extends ProfileState {}
