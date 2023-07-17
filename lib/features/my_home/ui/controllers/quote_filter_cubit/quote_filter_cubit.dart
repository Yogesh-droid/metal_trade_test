import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'quote_filter_state.dart';

class QuoteFilterCubit extends Cubit<QuoteFilterState> {
  final List<String> statusList = [];
  QuoteFilterCubit() : super(QuoteFilterCubitInitial());

  void addFilter(String filter) {
    statusList.contains(filter)
        ? statusList.remove(filter)
        : statusList.add(filter);
    emit(FilterStatusUpdate(statusList: statusList));
  }
}
