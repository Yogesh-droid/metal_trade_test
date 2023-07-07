part of 'rfq_seller_enquiry_bloc.dart';

@immutable
abstract class RfqSellerEnquiryState {}

class RfqSellerEnquiryInitial extends RfqSellerEnquiryState {}

class RfqSellerEnquiryLoadMore extends RfqSellerEnquiryState {}

class RfqSellerEnquiryFetchedState extends RfqSellerEnquiryState {
  final List<Content> sellerRfqList;

  RfqSellerEnquiryFetchedState({required this.sellerRfqList});
}

class RfqSellerEnquiryFailed extends RfqSellerEnquiryState {
  final Exception exception;

  RfqSellerEnquiryFailed({required this.exception});
}
