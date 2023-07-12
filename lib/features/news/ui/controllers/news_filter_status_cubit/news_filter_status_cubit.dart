import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_filter_status_state.dart';

class NewsFilterStatusCubit extends Cubit<NewsFilterStatusState> {
  final List<String> statusList = [];
  NewsFilterStatusCubit() : super(NewsFilterStatusInitial());

  void addFilter(String filter) {
    statusList.contains(filter)
        ? statusList.remove(filter)
        : statusList.add(filter);
    emit(NewsFilterStatusUpdate(statusList: statusList));
  }
}
