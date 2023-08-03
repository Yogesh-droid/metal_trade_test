part of 'kyc_file_pick_cubit.dart';

@immutable
abstract class KycFilePickState {}

class KycFilePickInitial extends KycFilePickState {}

class KycFilePickSuccess extends KycFilePickState {
  final File file;

  KycFilePickSuccess(this.file);
}

class KycFilePickeFailed extends KycFilePickState {
  final Exception exception;

  KycFilePickeFailed(this.exception);
}

class KycFilePicking extends KycFilePickState {
  KycFilePicking();
}
