part of 'chat_home_bloc.dart';

@immutable
abstract class ChatHomeState {}

class ChatHomeInitial extends ChatHomeState {}

class ChatHomeListFetched extends ChatHomeState {
  final List<Content> chatList;

  ChatHomeListFetched({required this.chatList});
}

class ChatHomeError extends ChatHomeState {
  final Exception exception;

  ChatHomeError(this.exception);
}
