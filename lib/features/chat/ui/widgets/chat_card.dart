import 'package:flutter/material.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_pointed_container.dart';
import 'package:metaltrade/features/chat/ui/widgets/text_chat_card.dart';

import 'chat_with_image.dart';
import 'enquiry_card.dart';
import 'quote_card.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.content, required this.isMyChat});
  final Content content;
  final bool isMyChat;

  @override
  Widget build(BuildContext context) {
    return content.body!.chatMessageType == "Enquiry"
        ? ChatPointedContainer(
            isMyChat: isMyChat,
            color: isMyChat
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.onSecondary,
            child: EnquiryCard(content: content))
        : content.body!.chatMessageType == "Quote"
            ? ChatPointedContainer(
                isMyChat: isMyChat,
                color: isMyChat
                    ? Theme.of(context).colorScheme.tertiaryContainer
                    : Theme.of(context).colorScheme.onSecondary,
                child: QuoteCard(content: content))
            : content.body!.chatMessageType == "Text"
                ? ChatPointedContainer(
                    isMyChat: isMyChat,
                    color: isMyChat
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : Theme.of(context).colorScheme.onSecondary,
                    child: TextChatCard(content: content),
                  )
                : content.body!.chatMessageType == "Attachment"
                    ? ChatPointedContainer(
                        isMyChat: isMyChat,
                        child: ChatWithImage(content: content),
                      )
                    : const SizedBox();
  }
}