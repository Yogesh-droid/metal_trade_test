part of 'country_cubit.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountrySuccess extends CountryState {
  final List<CountryEntity> countries;

  CountrySuccess(this.countries);
}

class CountryFailedState extends CountryState {
  final Exception exception;

  CountryFailedState(this.exception);
}
