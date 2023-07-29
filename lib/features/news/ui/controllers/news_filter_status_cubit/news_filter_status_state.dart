part of 'news_filter_status_cubit.dart';

@immutable
abstract class NewsFilterStatusState {}

class NewsFilterStatusInitial extends NewsFilterStatusState {}

class NewsFilterStatusUpdate extends NewsFilterStatusState {
  final String status;
  NewsFilterStatusUpdate({required this.status});
}
