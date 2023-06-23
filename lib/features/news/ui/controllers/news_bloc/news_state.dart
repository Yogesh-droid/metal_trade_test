part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsFetched extends NewsState {
  final List<News> newsList;

  NewsFetched(this.newsList);
}

class NewsFailed extends NewsState {
  final Exception exception;

  NewsFailed(this.exception);
}
