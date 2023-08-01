import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/spaces.dart';
import '../../controllers/chat_bloc/chat_bloc.dart';
import '../../controllers/chat_file_pick_cubit/chat_file_pick_cubit.dart';

class ChatFileUploadUi extends StatelessWidget {
  const ChatFileUploadUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatFileUploaded) {
        context.read<ChatFilePickCubit>().emitInitiaState();
        return Padding(
          padding: const EdgeInsets.all(appPadding),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: state.imgUrl,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            placeholder: (_, __) {
              return Image.file(
                fit: BoxFit.cover,
                context.read<ChatFilePickCubit>().pickedImage!,
              );
            },
          ),
        );
      } else if (state is ChatFileUpdalodFailed) {
        context.read<ChatFilePickCubit>().emitInitiaState();
        return Padding(
            padding: const EdgeInsets.all(appPadding),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.file(
                  fit: BoxFit.cover,
                  state.file!,
                ),
                Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.black.withOpacity(0.3),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                      size: 100,
                    ))
              ],
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
