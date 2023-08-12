import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'filter_status_state.dart';

class FilterStatusCubit extends Cubit<FilterStatusState> {
  final List<String> statusList = [];
  FilterStatusCubit() : super(FilterStatusInitial());

  void addFilter(List<String> filter) {
    if (filter.isNotEmpty) {
      statusList.contains(filter[0])
          ? filter[0] == "Complete"
              // ignore: avoid_function_literals_in_foreach_calls
              ? filter.forEach((element) {
                  if (statusList.contains(element)) {
                    statusList.remove(element);
                  } else {
                    statusList.add(element);
                  }
                })
              : statusList.remove(filter[0])
          : statusList.addAll(filter);
    } else {
      statusList.clear();
    }
    emit(FilterStatusUpdate(statusList: statusList));
  }
}
