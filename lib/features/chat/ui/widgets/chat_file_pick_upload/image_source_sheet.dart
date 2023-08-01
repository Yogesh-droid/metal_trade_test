import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/spaces.dart';
import '../../../../../core/constants/text_tyles.dart';
import '../../controllers/chat_file_pick_cubit/chat_file_pick_cubit.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: appPadding, horizontal: appPadding * 2),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Choose From',
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.outline)),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Container(
                  padding: const EdgeInsets.all(appFormFieldGap),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      shape: BoxShape.circle),
                  child: const Icon(Icons.close)),
            )
          ]),
          const Divider(),
          const SizedBox(height: appPadding),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(appPadding),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                      onPressed: () {
                        context.pop();
                        context
                            .read<ChatFilePickCubit>()
                            .getImageFromLib(ImageSource.gallery);
                      },
                      icon: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Text("Gallery",
                    style: secMed15.copyWith(
                        color: Theme.of(context).colorScheme.outline))
              ],
            ),
            const SizedBox(width: appWidgetGap),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(appPadding),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                      onPressed: () {
                        context.pop();
                        context
                            .read<ChatFilePickCubit>()
                            .getImageFromLib(ImageSource.camera);
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Text("Camera",
                    style: secMed15.copyWith(
                        color: Theme.of(context).colorScheme.outline))
              ],
            )
          ]),
          const SizedBox(height: appWidgetGap)
        ],
      ),
    );
  }
}
