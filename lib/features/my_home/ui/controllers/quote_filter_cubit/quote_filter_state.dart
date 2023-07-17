part of 'quote_filter_cubit.dart';

@immutable
abstract class QuoteFilterState {}

class QuoteFilterCubitInitial extends QuoteFilterState {}

class FilterStatusUpdate extends QuoteFilterState {
  final List<String> statusList;
  FilterStatusUpdate({required this.statusList});
}
