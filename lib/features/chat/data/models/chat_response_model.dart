import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';
import 'package:metaltrade/features/quotes/data/models/quote_res_model.dart';

class ChatResponseModel extends ChatResponseEntity {
  ChatResponseModel(
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
            totalPages: totalElements);

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
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
  String? lastModifiedDate;
  int? id;
  int? senderCompanyId;
  int? recipientCompanyId;
  int? enquiryId;
  int? quoteId;
  Body? body;
  String? status;

  Content(
      {this.lastModifiedDate,
      this.id,
      this.senderCompanyId,
      this.recipientCompanyId,
      this.enquiryId,
      this.quoteId,
      this.body,
      this.status});

  Content.fromJson(Map<String, dynamic> json) {
    lastModifiedDate = json["lastModifiedDate"];
    id = json["id"];
    senderCompanyId = json["senderCompanyId"];
    recipientCompanyId = json["recipientCompanyId"];
    enquiryId = json["enquiryId"];
    quoteId = json["quoteId"];
    body = json["body"] == null ? null : Body.fromJson(json["body"]);
    status = json["status"];
  }
}

class Body {
  int? id;
  String? chatMessageType;
  String? text;
  String? attachment;
  Enquiry? enquiry;
  Enquiry? quote;

  Body(
      {this.id,
      this.chatMessageType,
      this.text,
      this.attachment,
      this.enquiry,
      this.quote});

  Body.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    chatMessageType = json["chatMessageType"];
    text = json["text"];
    attachment = json['attachmentUrl'];
    enquiry =
        json["enquiry"] == null ? null : Enquiry.fromJson(json["enquiry"]);
    quote = json["quote"] == null ? null : Enquiry.fromJson(json["quote"]);
  }
}

class ReplyTo {
  int? id;
  String? chatMessageType;
  String? text;
  String? attachment;

  ReplyTo({
    this.id,
    this.chatMessageType,
    this.text,
    this.attachment,
  });

  ReplyTo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    chatMessageType = json["chatMessageType"];
    text = json["text"];
    attachment = json['attachmentUrl'];
  }
}
