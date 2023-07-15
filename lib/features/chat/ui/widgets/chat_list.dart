import 'package:flutter/material.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';

import 'chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chatList});
  final List<Content> chatList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: chatList
          .map((e) => ChatCard(
                content: e,
                isMyChat: e.senderCompanyId == 1,
              ))
          .toList(),
    );
  }
}
