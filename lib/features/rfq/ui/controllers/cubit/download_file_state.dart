part of 'download_file_cubit.dart';

@immutable
abstract class DownloadFileState {}

class DownloadFileInitial extends DownloadFileState {}

class DownloadFileSuccess extends DownloadFileState {
  final bool isSuccess;

  DownloadFileSuccess(this.isSuccess);
}

class FileDownloading extends DownloadFileState {
  final int progress;

  FileDownloading(this.progress);
}

class FileDownloadFailed extends DownloadFileState {
  final Exception? exception;

  FileDownloadFailed(this.exception);
}
