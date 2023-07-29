import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_filter_status_state.dart';

class NewsFilterStatusCubit extends Cubit<NewsFilterStatusState> {
  String status = '';
  NewsFilterStatusCubit() : super(NewsFilterStatusInitial());

  void addFilter(String filter) {
    status = filter;
    emit(NewsFilterStatusUpdate(status: status));
  }
}
