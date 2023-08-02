part of 'kyc_bloc.dart';

@immutable
abstract class KycEvent {}

class DoKycEvent extends KycEvent {
  final KycRequestModel kycRequestModel;

  DoKycEvent(this.kycRequestModel);
}

class UploadKycDoc extends KycEvent {
  final String fileName;
  final String filePath;

  UploadKycDoc({required this.fileName, required this.filePath});
}
