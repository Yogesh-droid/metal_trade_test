abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({super.data});
}

class DataError<T> extends DataState<T> {
  const DataError({super.exception});
}
