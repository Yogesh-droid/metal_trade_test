part of 'rfq_seller_enquiry_bloc.dart';

@immutable
abstract class RfqSellerEnquiryEvent {}

class GetRfqSellerEnquiryEvent extends RfqSellerEnquiryEvent {
  final UserIntent intent;
  final int page;

  GetRfqSellerEnquiryEvent({required this.intent, required this.page});
}
