part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatListSuccessState extends ChatState {
  final List<String> chats;

  ChatListSuccessState({required this.chats});
}

class PreviousChatLoaded extends ChatState {
  final List<Content> chatList;

  PreviousChatLoaded({required this.chatList});
}

class PreviousChatFailed extends ChatState {
  final Exception exception;

  PreviousChatFailed(this.exception);
}

class ChatFileUploaded extends ChatState {
  final String imgUrl;

  ChatFileUploaded({required this.imgUrl});
}

class ChatFileUploadFailed extends ChatState {
  final Exception exception;
  final File? file;
  ChatFileUploadFailed({required this.exception, this.file});
}

class ChatFileUploading extends ChatState {
  final int progress;

  ChatFileUploading(this.progress);
}

class PreviousChatLoading extends ChatState {}

class PreviousChatLoadMore extends ChatState {}
