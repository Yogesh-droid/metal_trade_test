part of 'news_filter_status_cubit.dart';

@immutable
abstract class NewsFilterStatusState {}

class NewsFilterStatusInitial extends NewsFilterStatusState {}

class NewsFilterStatusUpdate extends NewsFilterStatusState {
  final List<String> statusList;
  NewsFilterStatusUpdate({required this.statusList});
}
