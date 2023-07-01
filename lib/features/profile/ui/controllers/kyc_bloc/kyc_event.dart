part of 'kyc_bloc.dart';

@immutable
abstract class KycEvent {}

class DoKycEvent extends KycEvent {
  final KycRequestModel kycRequestModel;

  DoKycEvent(this.kycRequestModel);
}
