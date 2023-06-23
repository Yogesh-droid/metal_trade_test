part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class GetAllNewsEvent extends NewsEvent {
  final int page;
  final String future;

  GetAllNewsEvent({required this.page, required this.future});
}
