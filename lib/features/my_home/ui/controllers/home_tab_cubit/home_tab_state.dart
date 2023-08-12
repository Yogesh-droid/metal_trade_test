part of "home_tab_cubit.dart";

@immutable
abstract class HomeTabState {}

class HomeTabStateInitial extends HomeTabState {}

class HomeTabStateUpdate extends HomeTabState {
  final int index;
  HomeTabStateUpdate({required this.index});
}
