import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_status_state.dart';

class FilterStatusCubit extends Cubit<FilterStatusState> {
  final List<String> statusList = [];
  FilterStatusCubit() : super(FilterStatusInitial());

  void addFilter(String filter) {
    statusList.contains(filter)
        ? statusList.remove(filter)
        : statusList.add(filter);
    emit(FilterStatusUpdate(statusList: statusList));
  }
}
