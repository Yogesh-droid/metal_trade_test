part of 'create_enquiry_bloc.dart';

@immutable
abstract class CreateEnquiryEvent {}

class PostEnquiryEvent extends CreateEnquiryEvent {
  final PostEnquiryModel postEnquiryModel;

  PostEnquiryEvent({required this.postEnquiryModel});
}

class UploadEnquiryAttachment extends CreateEnquiryEvent {
  final String filaName;
  final String filePath;

  UploadEnquiryAttachment({required this.filaName, required this.filePath});
}
