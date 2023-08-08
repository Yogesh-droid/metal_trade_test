part of 'my_quote_bloc.dart';

@immutable
abstract class MyQuoteState {}

class MyQuoteInitial extends MyQuoteState {}

class MyQuoteFetchedState extends MyQuoteState {
  final List<Content> contentList;

  MyQuoteFetchedState({required this.contentList});
}

class MyQuoteFailedState extends MyQuoteState {
  final Exception exception;

  MyQuoteFailedState({required this.exception});
}

class MyQuoteLoadMore extends MyQuoteState {}

class MyQuoteUpdateSuccess extends MyQuoteState {
  final bool isUpdated;

  MyQuoteUpdateSuccess(this.isUpdated);
}

class MyQuoteUpdateFailed extends MyQuoteState {
  final Exception exception;

  MyQuoteUpdateFailed(this.exception);
}
