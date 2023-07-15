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
  final int? userId;
  GetPreviousChatEvent(
      {required this.chatType, this.page, this.enquiryId, this.userId});
}

class MessageReceived extends ChatEvent {
  final String message;

  MessageReceived(this.message);
}
