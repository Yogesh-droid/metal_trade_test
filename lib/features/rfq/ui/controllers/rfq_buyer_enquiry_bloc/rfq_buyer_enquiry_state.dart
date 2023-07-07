part of 'rfq_buyer_enquiry_bloc.dart';

@immutable
abstract class RfqBuyerEnquiryState {}

class RfqBuyerEnquiryInitial extends RfqBuyerEnquiryState {}

class RfqBuyerEnquiryLoadMore extends RfqBuyerEnquiryState {}

class RfqBuyerEnquiryFetchedState extends RfqBuyerEnquiryState {
  final List<Content> buyerEnquiryList;

  RfqBuyerEnquiryFetchedState({required this.buyerEnquiryList});
}

class RfqBuyerEnquiryFailed extends RfqBuyerEnquiryState {
  final Exception exception;

  RfqBuyerEnquiryFailed({required this.exception});
}
