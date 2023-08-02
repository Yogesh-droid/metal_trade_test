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

class KycFIleUploadSuccess extends KycState {
  final String url;

  KycFIleUploadSuccess(this.url);
}

class KycFileUploadFailed extends KycState {
  final Exception exception;

  KycFileUploadFailed(this.exception);
}

class KycFileUploading extends KycState {
  final int? progress;

  KycFileUploading(this.progress);
}
