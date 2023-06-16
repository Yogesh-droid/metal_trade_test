part of 'home_page_buyer_enquiry_bloc.dart';

@immutable
abstract class HomePageEnquiryEvent {}

class GetHomeBuyerPageEnquiryEvent extends HomePageEnquiryEvent {
  final UserIntent intent;
  final int page;

  GetHomeBuyerPageEnquiryEvent({required this.page, required this.intent});
}

// ignore: constant_identifier_names
enum UserIntent { BUY_INTENT, SELL_INTENT }
