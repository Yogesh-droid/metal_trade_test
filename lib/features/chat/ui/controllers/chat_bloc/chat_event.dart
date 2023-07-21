part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatInitiateEvent extends ChatEvent {
  final String message;
  final int receiverId;

  ChatInitiateEvent({required this.message, required this.receiverId});
}

class GetPreviousChatEvent extends ChatEvent {
  final String chatType;
  final int? page;
  final int? enquiryId;
  GetPreviousChatEvent({required this.chatType, this.page, this.enquiryId});
}

class MessageReceived extends ChatEvent {
  final String message;

  MessageReceived(this.message);
}

class AddNewChat extends ChatEvent {
  final Map<String, dynamic> chat;

  AddNewChat(this.chat);
}
