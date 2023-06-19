part of 'my_enquiry_buy_bloc.dart';

@immutable
abstract class MyEnquiryState {}

class MyEnquiryInitial extends MyEnquiryState {}

class MyEnquiryFetchedState extends MyEnquiryState {
  final List<Content> contentList;

  MyEnquiryFetchedState({required this.contentList});
}

class MyEnquiryFailedState extends MyEnquiryState {
  final Exception exception;

  MyEnquiryFailedState({required this.exception});
}
