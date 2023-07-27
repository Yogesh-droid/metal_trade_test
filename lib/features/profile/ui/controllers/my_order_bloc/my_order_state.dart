part of 'my_order_bloc.dart';

@immutable
abstract class MyOrderState {}

class MyOrderInitial extends MyOrderState {}

class MyOrderLoading extends MyOrderState {}

class MyOrderFailed extends MyOrderState {
  final Exception exception;

  MyOrderFailed({required this.exception});
}

class MyOrderSuccess extends MyOrderState {
  final List<Content> myOrderList;

  MyOrderSuccess(this.myOrderList);
}
