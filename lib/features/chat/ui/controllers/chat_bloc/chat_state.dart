part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSocketConnectedState extends ChatState {
  final Stream<dynamic> socketStream;

  ChatSocketConnectedState({required this.socketStream});
}

class ChatDisconnected extends ChatState {}

class ChatSocketFailed extends ChatState {
  final WebSocketChannelException webSocketChannelException;

  ChatSocketFailed({required this.webSocketChannelException});
}

class ChatListSuccessState extends ChatState {
  final List<String> chats;

  ChatListSuccessState({required this.chats});
}

class MessageReceivedState extends ChatState {
  final String message;

  MessageReceivedState(this.message);
}

class PreviousChatLoaded extends ChatState {
  final List<Content> chatList;

  PreviousChatLoaded({required this.chatList});
}

class PreviousChatFailed extends ChatState {
  final Exception exception;

  PreviousChatFailed(this.exception);
}

class PreviousChatLoading extends ChatState {}

class PreviousChatLoadMore extends ChatState {}
