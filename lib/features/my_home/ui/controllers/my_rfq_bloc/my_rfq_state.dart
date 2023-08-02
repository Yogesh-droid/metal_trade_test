part of 'my_rfq_bloc.dart';

@immutable
abstract class MyRfqState {}

class MyRfqInitial extends MyRfqState {}

class MyRfqFetchedState extends MyRfqState {
  final List<Content> contentList;

  MyRfqFetchedState({required this.contentList});
}

class MyRfqFailedState extends MyRfqState {
  final Exception exception;

  MyRfqFailedState({required this.exception});
}

class MyRfqLoadMore extends MyRfqState {}

//  update rfq's //

class UpdateRfqSuccess extends MyRfqState {
  final Content content;

  UpdateRfqSuccess(this.content);
}

class UpdatingRfq extends MyRfqState {}

class UpdateRfqFailed extends MyRfqState {
  final Exception exception;

  UpdateRfqFailed(this.exception);
}
