part of 'kyc_bloc.dart';

@immutable
abstract class KycState {}

class KycInitial extends KycState {}

class KycDoneState extends KycState {
  final ProfileEntity profileEntity;

  KycDoneState(this.profileEntity);
}

class KycFailedState extends KycState {
  final Exception exception;

  KycFailedState(this.exception);
}
