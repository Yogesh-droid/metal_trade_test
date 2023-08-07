import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/spaces.dart';
import '../../../../../core/constants/text_tyles.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet(
      {super.key,
      required this.onCameraTapped,
      required this.onGalleryTapped,
      required this.onFileTapped});
  final Function() onCameraTapped;
  final Function() onGalleryTapped;
  final Function() onFileTapped;

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
                        onGalleryTapped();
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
                        onCameraTapped();
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
                        onFileTapped();
                      },
                      icon: const Icon(
                        Icons.file_open,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Text("Files",
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
