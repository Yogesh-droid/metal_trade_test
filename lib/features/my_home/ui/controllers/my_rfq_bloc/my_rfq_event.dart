part of 'my_rfq_bloc.dart';

@immutable
abstract class MyRfqEvent {}

class GetMyRfqList extends MyRfqEvent {
  final List<String>? status;
  final int page;
  final bool isLoadMore;

  GetMyRfqList({this.status, required this.isLoadMore, required this.page});
}

class UpdateMyRfq extends MyRfqEvent {
  final String status;
  final int id;

  UpdateMyRfq({required this.status, required this.id});
}

class GetMyRfqLoadMore extends MyRfqEvent {}
