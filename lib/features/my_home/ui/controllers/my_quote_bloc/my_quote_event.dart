part of 'my_quote_bloc.dart';

@immutable
abstract class MyQuoteEvent {}

class GetQuoteList extends MyQuoteEvent {
  final List<String> status;
  final int? page;

  GetQuoteList({required this.status, this.page});
}
