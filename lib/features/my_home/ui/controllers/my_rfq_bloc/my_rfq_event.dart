part of 'my_rfq_bloc.dart';

@immutable
abstract class MyRfqEvent {}

class GetMyRfqList extends MyRfqEvent {
  final List<String>? status;
  final int page;
  final bool isLoadMore;

  GetMyRfqList({this.status, required this.isLoadMore, required this.page});
}

class GetMyRfqLoadMore extends MyRfqEvent {}
