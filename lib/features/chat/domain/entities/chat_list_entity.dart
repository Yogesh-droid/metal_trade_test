import '../../data/models/chat_list_model.dart';

class ChatListEntity {
  final List<Content>? content;
  final int? totalPages;
  final int? totalElements;
  final bool? last;
  final int? size;
  final int? number;
  final int? numberOfElements;
  final bool? first;
  final bool? empty;

  ChatListEntity(
      {this.content,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.numberOfElements,
      this.first,
      this.empty});
}
