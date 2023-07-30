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
  final bool? isLoadMore;
  GetPreviousChatEvent({
    required this.chatType,
    this.page,
    this.enquiryId,
    this.isLoadMore,
  });
}

class AddNewChat extends ChatEvent {
  final Map<String, dynamic> chat;

  AddNewChat(this.chat);
}

class UploadChatFile extends ChatEvent {
  final File? file;
  UploadChatFile({required this.file});
}
