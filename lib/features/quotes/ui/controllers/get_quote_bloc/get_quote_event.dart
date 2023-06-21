part of 'get_quote_bloc.dart';

@immutable
abstract class GetQuoteEvent {}

class GetAllQuoteEvent extends GetQuoteEvent {
  final int pageNo;
  final List<String> statusList;

  GetAllQuoteEvent({required this.pageNo, required this.statusList});
}
