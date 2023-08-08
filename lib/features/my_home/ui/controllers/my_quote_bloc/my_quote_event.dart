part of 'my_quote_bloc.dart';

@immutable
abstract class MyQuoteEvent {}

class GetQuoteList extends MyQuoteEvent {
  final List<String> status;
  final int? page;
  final bool isLoadMore;

  GetQuoteList({required this.status, required this.isLoadMore, this.page});
}

class UpdateMyQuoteStatus extends MyQuoteEvent {
  final int quoteId;
  final String status;

  UpdateMyQuoteStatus(this.quoteId, this.status);
}
