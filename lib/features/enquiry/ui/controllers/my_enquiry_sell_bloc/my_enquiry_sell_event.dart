part of 'my_enquiry_sell_bloc.dart';

@immutable
abstract class MyEnquirySellEvent {}

class GetMyEnquirySellList extends MyEnquirySellEvent {
  final UserIntent intent;
  final List<String> status;
  final int? page;

  GetMyEnquirySellList({required this.intent, required this.status, this.page});
}
