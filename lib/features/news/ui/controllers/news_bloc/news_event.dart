part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetAllNewsEvent extends NewsEvent {
  final int page;
  final String? filters;

  GetAllNewsEvent({required this.page, this.filters});
}
