part of 'accept_quote_bloc.dart';

@immutable
abstract class AcceptQuoteEvent {}

class QuoteAcceptEvent extends AcceptQuoteEvent {
  final int quoteId;
  final String status;

  QuoteAcceptEvent({required this.quoteId, required this.status});
}
