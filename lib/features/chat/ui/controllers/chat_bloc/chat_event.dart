part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatInitiateEvent extends ChatEvent {
  final String message;
  final int receiverId;

  ChatInitiateEvent({required this.message, required this.receiverId});
}

class GetPreviousChatEvent extends ChatEvent {}

class MessageReceived extends ChatEvent {
  final String message;

  MessageReceived(this.message);
}
