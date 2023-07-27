part of 'my_order_bloc.dart';

@immutable
abstract class MyOrderEvent {}

class GetMyOrderEvent extends MyOrderEvent {
  final bool isLoadMore;
  final int pageNo;

  GetMyOrderEvent({required this.isLoadMore, required this.pageNo});
}
