import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_btn_cubit/chat_btn_cubit.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_file_pick_upload/chat_file_pick_ui.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_file_pick_upload/chat_file_upload_ui.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_send_btn.dart';

class ChatImageDialog extends StatelessWidget {
  const ChatImageDialog({super.key, required this.onSendBtnTapped});
  final Function(String text, String? imgUrl) onSendBtnTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Dialog.fullscreen(
          child: Stack(
            children: [
              const Stack(
                alignment: Alignment.center,
                children: [
                  ChatFilePickUi(),
                  ChatFileUploadUi(),
                ],
              ),
              Column(
                children: [
                  Container(
                      height: 80,
                      padding: const EdgeInsets.all(appPadding),
                      color: Colors.black.withOpacity(0.5),
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              context.read<ChatBtnCubit>().changeState(false);
                              context.pop();
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white)),
                        Text(kSelectedImg,
                            style: secMed14.copyWith(color: Colors.white))
                      ])),
                  const Spacer(),
                  ChatSendBtn(onSendBtnTapped: (text, imagUrl) {
                    context.pop();
                    onSendBtnTapped(text, imagUrl);
                  }),
                ],
              )
            ],
          ),
        ));
  }
}
