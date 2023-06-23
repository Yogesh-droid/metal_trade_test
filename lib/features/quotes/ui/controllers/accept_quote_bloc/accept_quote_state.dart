part of 'accept_quote_bloc.dart';

@immutable
abstract class AcceptQuoteState {}

class AcceptQuoteInitial extends AcceptQuoteState {}

class AcceptQuoteSuccessful extends AcceptQuoteState {
  final AcceptQuoteResEntity acceptQuoteResEntity;

  AcceptQuoteSuccessful(this.acceptQuoteResEntity);
}

class AcceptQuoteFailed extends AcceptQuoteState {
  final Exception exception;

  AcceptQuoteFailed(this.exception);
}
