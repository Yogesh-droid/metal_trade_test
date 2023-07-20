part of 'quote_detail_list_bloc.dart';

@immutable
abstract class QuoteDetailListEvent {}

class GetQuoteDetailList extends QuoteDetailListEvent {
  final int page;
  final int enquiryId;
  final bool isLoadMore;

  GetQuoteDetailList(
      {required this.page, required this.isLoadMore, required this.enquiryId});
}
