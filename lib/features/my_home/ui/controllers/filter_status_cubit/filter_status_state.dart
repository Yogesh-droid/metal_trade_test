part of 'filter_status_cubit.dart';

@immutable
abstract class FilterStatusState {}

class FilterStatusInitial extends FilterStatusState {}

class FilterStatusUpdate extends FilterStatusState {
  final List<String> statusList;
  FilterStatusUpdate({required this.statusList});
}
