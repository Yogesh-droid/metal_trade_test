part of 'chat_home_bloc.dart';

@immutable
abstract class ChatHomeEvent {}

class GetChatHomeList extends ChatHomeEvent {
  final int page;

  GetChatHomeList({required this.page});
}
