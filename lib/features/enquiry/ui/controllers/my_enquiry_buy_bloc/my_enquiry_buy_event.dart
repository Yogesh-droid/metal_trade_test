part of 'my_enquiry_buy_bloc.dart';

@immutable
abstract class MyEnquiryEvent {}

class GetMyEnquiryList extends MyEnquiryEvent {
  final UserIntent intent;
  final List<String> status;
  final int page;

  GetMyEnquiryList(
      {required this.intent, required this.status, required this.page});
}
