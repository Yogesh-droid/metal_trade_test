part of 'home_page_seller_enquiry_bloc.dart';

@immutable
abstract class HomePageSellerEnquiryEvent {}

class GetHomePageSellerEnquiryEvent extends HomePageSellerEnquiryEvent {
  final UserIntent intent;
  final int page;

  GetHomePageSellerEnquiryEvent({required this.intent, required this.page});
}
