part of 'rfq_buyer_enquiry_bloc.dart';

@immutable
abstract class RfqEnquiryEvent {}

class GetRfqBuyerPageEnquiryEvent extends RfqEnquiryEvent {
  final UserIntent intent;
  final int page;

  GetRfqBuyerPageEnquiryEvent({required this.page, required this.intent});
}

// ignore: constant_identifier_names
enum UserIntent { Buy, Sell }
