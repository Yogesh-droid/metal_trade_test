part of 'submit_quote_bloc.dart';

@immutable
abstract class SubmitQuoteEvent {}

class SubmitQuote extends SubmitQuoteEvent {
  final PostEnquiryModel postEnquiryModel;
  final int quoteId;

  SubmitQuote({required this.postEnquiryModel, required this.quoteId});
}
