part of 'accept_quote_bloc.dart';

@immutable
abstract class AcceptQuoteEvent {}

class QuoteAcceptEvent extends AcceptQuoteEvent {
  final int quoteId;
  final String status;

  QuoteAcceptEvent({required this.quoteId, required this.status});
}

class QuoteCancelEvent extends AcceptQuoteEvent {
  final int quoteId;
  final String status;

  QuoteCancelEvent({required this.quoteId, required this.status});
}
