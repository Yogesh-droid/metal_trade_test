part of 'create_enquiry_bloc.dart';

@immutable
abstract class CreateEnquiryState {}

class CreateEnquiryInitial extends CreateEnquiryState {}

class PostEnquirySuccessful extends CreateEnquiryState {
  final PostEnquiryResEntity postEnquiryResEntity;

  PostEnquirySuccessful(this.postEnquiryResEntity);
}

class PostEnquiryFailed extends CreateEnquiryState {
  final Exception exception;

  PostEnquiryFailed(this.exception);
}

class PostEnquiryInProgress extends CreateEnquiryState {}

class EnquiryFileUploading extends CreateEnquiryState {
  final int value;

  EnquiryFileUploading(this.value);
}

class EnquiryFileUploadSuccess extends CreateEnquiryState {
  final String url;
  EnquiryFileUploadSuccess(this.url);
}

class EnquiryFileUploadFailed extends CreateEnquiryState {
  final Exception exception;

  EnquiryFileUploadFailed(this.exception);
}
