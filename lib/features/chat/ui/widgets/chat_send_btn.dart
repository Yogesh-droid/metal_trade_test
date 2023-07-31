import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_pointed_container.dart';
import '../../../../core/constants/spaces.dart';
import '../controllers/chat_file_pick_cubit/chat_file_pick_cubit.dart';

class ChatSendBtn extends StatelessWidget {
  const ChatSendBtn({super.key, required this.onSendBtnTapped});
  final Function(String text, String? imgUrl) onSendBtnTapped;

  @override
  Widget build(BuildContext context) {
    String? imgUrl;
    final TextEditingController textEditingController = TextEditingController();
    return Column(
      children: [
        const SizedBox(height: appPadding),
        BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is ChatFileUploaded) {
            context.read<ChatFilePickCubit>().emitInitiaState();
            imgUrl = state.imgUrl;
            return ChatPointedContainer(
              isMyChat: true,
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: CachedNetworkImage(
                  imageUrl: state.imgUrl,
                  height: 250,
                  width: 150,
                ),
              ),
            );
          } else if (state is ChatFileUpdalodFailed) {
            context.read<ChatFilePickCubit>().emitInitiaState();
            return ChatPointedContainer(
              isMyChat: true,
              child: Padding(
                  padding: const EdgeInsets.all(appPadding),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        state.file!,
                      ),
                      Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width / 1.2,
                          color: Colors.black.withOpacity(0.3),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 100,
                          ))
                    ],
                  )),
            );
          }
          return const SizedBox.shrink();
        }),
        BlocConsumer<ChatFilePickCubit, ChatFilePickState>(
            listener: (context, state) {
          if (state is ChatFilePickSuccess) {
            context.read<ChatBloc>().add(UploadChatFile(file: state.file));
          }
        }, builder: (context, state) {
          if (state is ChatFilePicking) {
            return const SizedBox.shrink();
          }
          if (state is ChatFilePickSuccess) {
            return BlocBuilder<ChatBloc, ChatState>(
              builder: (context, chatState) {
                if (chatState is ChatFileuploading) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ChatPointedContainer(
                        isMyChat: true,
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(appPadding),
                          child: Image.file(
                            state.file!,
                            height: 250,
                            width: 150,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        height: 250,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                value: chatState.progress / 100,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                            Text("${chatState.progress} %",
                                style: secMed12.copyWith(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const SizedBox.shrink();
        }),
        Card(
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
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!))),
                        controller: textEditingController)),
                const SizedBox(width: appPadding),
                InkWell(
                    onTap: () {
                      openChooseImageSourceSheet(context);
                    },
                    child: const Icon(Icons.attachment)),
                const SizedBox(width: appPadding),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                      onPressed: () {
                        onSendBtnTapped(textEditingController.text, imgUrl);
                      },
                      color: Colors.white,
                      icon: const Icon(Icons.send)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  openChooseImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<ChatFilePickCubit>()
                            .getImageFromLib(ImageSource.gallery);
                      },
                      icon: const Icon(
                        Icons.photo_library,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: () {
                        context
                            .read<ChatFilePickCubit>()
                            .getImageFromLib(ImageSource.camera);
                      },
                      icon: const Icon(
                        Icons.camera,
                        size: 50,
                      ))
                ]),
          );
        });
  }
}
