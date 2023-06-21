part of 'get_quote_bloc.dart';

@immutable
abstract class GetQuoteState {}

class GetQuoteInitial extends GetQuoteState {}

class GetAllQuoteFetched extends GetQuoteState {
  final List<Content> quoteList;

  GetAllQuoteFetched({required this.quoteList});
}

class GetQuoteFailedState extends GetQuoteState {
  final Exception exception;

  GetQuoteFailedState({required this.exception});
}
