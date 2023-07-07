part of 'my_rfq_bloc.dart';

@immutable
abstract class MyRfqEvent {}

class GetMyRfqList extends MyRfqEvent {
  final List<String>? status;
  final int page;

  GetMyRfqList({this.status, required this.page});
}
