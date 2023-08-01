import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/spaces.dart';
import '../../../../../core/constants/text_tyles.dart';
import '../../controllers/chat_bloc/chat_bloc.dart';
import '../../controllers/chat_file_pick_cubit/chat_file_pick_cubit.dart';

class ChatFilePickUi extends StatelessWidget {
  const ChatFilePickUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatFilePickCubit, ChatFilePickState>(
        builder: (context, state) {
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
                  Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Image.file(
                      state.file!,
                      fit: BoxFit.cover,
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
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
    });
  }
}
