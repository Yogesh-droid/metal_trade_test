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
  final int? quoteId;
  GetPreviousChatEvent({
    required this.chatType,
    this.page,
    this.quoteId,
    this.enquiryId,
    this.isLoadMore,
  });
}

class AddNewChat extends ChatEvent {
  final Content chat;

  AddNewChat(this.chat);
}

class UploadChatFile extends ChatEvent {
  final File? file;
  UploadChatFile({required this.file});
}
