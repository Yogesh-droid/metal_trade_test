part of 'my_enquiry_sell_bloc.dart';

@immutable
abstract class MyEnquirySellState {}

class MyEnquirySellInitial extends MyEnquirySellState {}

class MyEnquirySellFetchedState extends MyEnquirySellState {
  final List<Content> contentList;

  MyEnquirySellFetchedState({required this.contentList});
}

class MyEnquirySellFailedState extends MyEnquirySellState {
  final Exception exception;

  MyEnquirySellFailedState({required this.exception});
}
