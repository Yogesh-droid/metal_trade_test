part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchByText extends SearchEvent {
  final String text;

  SearchByText({required this.text});
}
