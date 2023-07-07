part of 'my_rfq_bloc.dart';

@immutable
abstract class MyRfqEvent {}

class GetMyRfqList extends MyRfqEvent {
  final UserIntent intent;
  final List<String> status;
  final int page;

  GetMyRfqList(
      {required this.intent, required this.status, required this.page});
}
