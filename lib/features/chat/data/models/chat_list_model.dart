import 'package:metaltrade/features/chat/domain/entities/chat_list_entity.dart';

class ChatListModel extends ChatListEntity {
  ChatListModel(
      {List<Content>? content,
      int? totalPages,
      int? totalElements,
      bool? last,
      int? size,
      int? number,
      int? numberOfElements,
      bool? first,
      bool? empty})
      : super(
            content: content,
            empty: empty,
            first: first,
            last: last,
            number: number,
            numberOfElements: numberOfElements,
            size: size,
            totalElements: totalElements,
            totalPages: totalPages);

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      content: json["content"] == null
          ? null
          : (json["content"] as List).map((e) => Content.fromJson(e)).toList(),
      totalPages: json["totalPages"],
      totalElements: json["totalElements"],
      last: json["last"],
      size: json["size"],
      number: json["number"],
      numberOfElements: json["numberOfElements"],
      first: json["first"],
      empty: json["empty"],
    );
  }
}

class Content {
  int? enquiryId;
  int? unseenChatCount;
  String? lastChatDate;
  String? heading;

  Content(
      {this.enquiryId, this.unseenChatCount, this.lastChatDate, this.heading});

  Content.fromJson(Map<String, dynamic> json) {
    enquiryId = json["enquiryId"];
    unseenChatCount = json["unseenChatCount"];
    lastChatDate = json["lastChatDate"];
    heading = json["heading"];
  }
}
