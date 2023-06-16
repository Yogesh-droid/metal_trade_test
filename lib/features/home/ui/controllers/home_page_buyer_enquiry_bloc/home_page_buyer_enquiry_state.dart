part of 'home_page_buyer_enquiry_bloc.dart';

@immutable
abstract class HomePageBuyerEnquiryState {}

class HomePageBuyerEnquiryInitial extends HomePageBuyerEnquiryState {}

class HomePageBuyerEnquiryFetchedState extends HomePageBuyerEnquiryState {
  final List<Content> buyerEnquiryList;

  HomePageBuyerEnquiryFetchedState({required this.buyerEnquiryList});
}

class HoemPageBuyerEnquiryFailed extends HomePageBuyerEnquiryState {
  final Exception exception;

  HoemPageBuyerEnquiryFailed({required this.exception});
}
