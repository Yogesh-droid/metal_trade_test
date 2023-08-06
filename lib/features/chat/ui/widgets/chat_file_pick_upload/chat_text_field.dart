import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_btn_cubit/chat_btn_cubit.dart';
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: appPadding * 2, vertical: appPadding),
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey[300]!))),
                    controller: textEditingController,
                    onChanged: (value) {
                      if (value.isEmpty && imgUrl.isEmpty) {
                        context.read<ChatBtnCubit>().changeState(false);
                      } else {
                        context.read<ChatBtnCubit>().changeState(true);
                      }
                    },
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
                  context.read<ChatBtnCubit>().changeState(true);
                  imgUrl = state.imgUrl;
                  focusNode.requestFocus();
                }
              },
              child: BlocBuilder<ChatBtnCubit, bool>(
                builder: (context, state) {
                  return CircleAvatar(
                    backgroundColor: state
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                    child: IconButton(
                        onPressed: () {
                          if (state) {
                            onSendBtnTapped(textEditingController.text, imgUrl);
                            textEditingController.clear();
                            imgUrl = '';
                          } else {
                            return;
                          }
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.send)),
                  );
                },
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
