part of 'home_page_seller_enquiry_bloc.dart';

@immutable
abstract class HomePageSellerEnquiryState {}

class HomePageSellerEnquiryInitial extends HomePageSellerEnquiryState {}

class HomePageSellerEnquiryLoadMore extends HomePageSellerEnquiryState {}

class HomePageSellerEnquiryFetchedState extends HomePageSellerEnquiryState {
  final List<Content> sellerEnquiryList;

  HomePageSellerEnquiryFetchedState({required this.sellerEnquiryList});
}

class HoemPageSellerEnquiryFailed extends HomePageSellerEnquiryState {
  final Exception exception;

  HoemPageSellerEnquiryFailed({required this.exception});
}
