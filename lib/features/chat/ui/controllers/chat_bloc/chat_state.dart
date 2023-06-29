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