part of 'quote_detail_list_bloc.dart';

@immutable
abstract class QuoteDetailListState {}

class QuoteDetailListInitial extends QuoteDetailListState {}

class QuoteDetailListSuccess extends QuoteDetailListState {
  final List<Content> contentList;

  QuoteDetailListSuccess({required this.contentList});
}

class QuoteDetailListFailed extends QuoteDetailListState {
  final Exception exception;

  QuoteDetailListFailed(this.exception);
}
