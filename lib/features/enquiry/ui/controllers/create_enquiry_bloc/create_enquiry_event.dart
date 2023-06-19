part of 'create_enquiry_bloc.dart';

@immutable
abstract class CreateEnquiryEvent {}

class PostEnquiryEvent extends CreateEnquiryEvent {
  final PostEnquiryModel postEnquiryModel;

  PostEnquiryEvent({required this.postEnquiryModel});
}
