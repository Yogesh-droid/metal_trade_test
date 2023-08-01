import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_file_pick_upload/image_source_sheet.dart';

import '../../../../../core/constants/spaces.dart';
import '../../controllers/chat_bloc/chat_bloc.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField(
      {super.key,
      required this.onSendBtnTapped,
      required this.textEditingController});
  final Function(String text, String? imgUrl) onSendBtnTapped;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    String imgUrl = '';
    final FocusNode focusNode = FocusNode();
    return Card(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(appPadding),
        color: Colors.grey[100],
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter your message",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(8),
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!))),
                    controller: textEditingController,
                    focusNode: focusNode)),
            const SizedBox(width: appPadding),
            InkWell(
                onTap: () {
                  openChooseImageSourceSheet(context);
                },
                child: const Icon(Icons.attachment)),
            const SizedBox(width: appPadding),
            BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatFileUploaded) {
                  imgUrl = state.imgUrl;
                  focusNode.requestFocus();
                }
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                    onPressed: () {
                      onSendBtnTapped(textEditingController.text, imgUrl);
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.send)),
              ),
            )
          ],
        ),
      ),
    );
  }

  openChooseImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ImageSourceSheet();
        });
  }
}
