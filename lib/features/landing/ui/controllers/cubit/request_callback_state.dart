part of 'request_callback_cubit.dart';

@immutable
abstract class RequestCallbackState {}

class RequestCallbackInitial extends RequestCallbackState {}

class RequestCallbackFailed extends RequestCallbackState {
  final Exception exception;

  RequestCallbackFailed(this.exception);
}

class RequestCallbackSuccess extends RequestCallbackState {
  final RequestCallbackEntity requestCallbackEntity;

  RequestCallbackSuccess(this.requestCallbackEntity);
}

class RequestCallbackLoading extends RequestCallbackState {}
