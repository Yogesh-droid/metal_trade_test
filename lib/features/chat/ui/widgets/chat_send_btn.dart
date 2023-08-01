import 'package:flutter/material.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_file_pick_upload/chat_text_field.dart';

class ChatSendBtn extends StatelessWidget {
  const ChatSendBtn({super.key, required this.onSendBtnTapped, this.focusNode});
  final Function(String text, String? imgUrl) onSendBtnTapped;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return ChatTextField(
        onSendBtnTapped: onSendBtnTapped,
        textEditingController: textEditingController);
  }
}
