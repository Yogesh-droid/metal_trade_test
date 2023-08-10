part of 'enquiry_file_pick_cubit.dart';

@immutable
abstract class EnquiryFilePickState {}

class EnquiryFilePickInitial extends EnquiryFilePickState {}

class EnquiryFilePickSuccess extends EnquiryFilePickState {
  final File file;

  EnquiryFilePickSuccess(this.file);
}

class EnquiryFilePicking extends EnquiryFilePickState {}

class EnquiryFilePickFailed extends EnquiryFilePickState {
  final Exception? exception;

  EnquiryFilePickFailed(this.exception);
}
