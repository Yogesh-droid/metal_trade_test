part of 'chat_file_pick_cubit.dart';

@immutable
abstract class ChatFilePickState {}

class ChatFilePickInitial extends ChatFilePickState {}

class ChatFilePickSuccess extends ChatFilePickState {
  final File? file;

  ChatFilePickSuccess(this.file);
}

class ChatFilePicking extends ChatFilePickState {}

class ChatFilePickFailed extends ChatFilePickState {
  final Exception? exception;

  ChatFilePickFailed(this.exception);
}
