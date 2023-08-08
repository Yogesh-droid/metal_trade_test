part of 'my_quote_bloc.dart';

@immutable
abstract class MyQuoteEvent {}

class GetQuoteList extends MyQuoteEvent {
  final List<String> status;
  final int? page;
  final bool isLoadMore;

  GetQuoteList({required this.status, required this.isLoadMore, this.page});
}

class UpdateQuoteStatus extends MyQuoteEvent {
  final int quoteId;
  final String status;

  UpdateQuoteStatus({required this.quoteId, required this.status});
}
