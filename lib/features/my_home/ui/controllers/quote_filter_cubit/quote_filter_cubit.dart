import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'quote_filter_state.dart';

class QuoteFilterCubit extends Cubit<QuoteFilterState> {
  final List<String> statusList = [];
  QuoteFilterCubit() : super(QuoteFilterCubitInitial());

  void addFilter(List<String> filter) {
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
    emit(FilterStatusUpdate(statusList: statusList));
  }
}
