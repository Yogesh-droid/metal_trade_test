part of 'accept_quote_bloc.dart';

@immutable
abstract class AcceptQuoteEvent {}

class QuoteAcceptEvent extends AcceptQuoteEvent {
  final int quoteId;

  QuoteAcceptEvent({required this.quoteId});
}
