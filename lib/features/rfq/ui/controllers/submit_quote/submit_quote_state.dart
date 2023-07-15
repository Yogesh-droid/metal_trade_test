part of 'submit_quote_bloc.dart';

@immutable
abstract class SubmitQuoteState {}

class SubmitQuoteInitial extends SubmitQuoteState {}

class SubmittingQuote extends SubmitQuoteState {}

class SubmitQuoteSuccessful extends SubmitQuoteState {
  final SubmitQuoteModel submitQuoteModel;

  SubmitQuoteSuccessful({required this.submitQuoteModel});
}

class SubmitQuoteFailed extends SubmitQuoteState {
  final Exception exception;

  SubmitQuoteFailed({required this.exception});
}
