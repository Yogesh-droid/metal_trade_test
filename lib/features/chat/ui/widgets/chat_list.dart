import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';

import 'chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.chatList});
  final List<Content> chatList;

  @override
  Widget build(BuildContext context) {
    return chatList.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ChatCard(
              content: chatList[index],
              isMyChat: chatList[index].senderCompanyId == 1,
            ),
            itemCount: chatList.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: appPadding * 2),
          )
        : const Center(
            child: Text("Sorry No chat found"),
          );
  }
}
