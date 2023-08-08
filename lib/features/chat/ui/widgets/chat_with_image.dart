import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/assets.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/rfq/ui/controllers/cubit/download_file_cubit.dart';

import '../../../../core/constants/text_tyles.dart';

class ChatWithImage extends StatelessWidget {
  const ChatWithImage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer),
            child: content.body!.attachment!
                            .split(RegExp(r'[\/_\-.\s]'))
                            .last ==
                        'jpg' ||
                    content.body!.attachment!
                            .split(RegExp(r'[\/_\-.\s]'))
                            .last ==
                        'png'
                ? CachedNetworkImage(
                    imageUrl: content.body!.attachment ?? '',
                    placeholder: (context, url) {
                      return Container(
                          height: 200,
                          color: Theme.of(context).colorScheme.outline);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(Assets.assetsProfileNoImage,
                          height: 200,
                          width: MediaQuery.of(context).size.width / 1.2,
                          fit: BoxFit.cover);
                    })
                : BlocBuilder<DownloadFileCubit, DownloadFileState>(
                    builder: (context, state) {
                      if (state is DownloadFileSuccess) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Fluttertoast.showToast(
                              msg: 'File downloaded successfully');
                        });
                      }
                      if (state is FileDownloadFailed) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Fluttertoast.showToast(
                              msg:
                                  'File Could not be downloaded, Please try again');
                        });
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(content.body!.attachment!
                                    .split(RegExp(r'[/-]'))
                                    .last),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<DownloadFileCubit>()
                                          .downloadFile(
                                              content.body!.attachment ?? '');
                                    },
                                    icon: const Icon(Icons.download))
                              ],
                            ),
                            if (state is FileDownloading)
                              Container(
                                height: 50,
                                color: Colors.blueGrey.withOpacity(0.5),
                                child: const Center(
                                  child: LinearProgressIndicator(
                                      // minHeight: 30,
                                      // value: state.progress / 100,
                                      // backgroundColor: Colors.black.withOpacity(0.5),
                                      // valueColor:
                                      //     const AlwaysStoppedAnimation(Colors.white),
                                      ),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  )),
        const SizedBox(height: appPadding),
        Text(content.body!.text ?? ''),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (DateTime.tryParse(content.lastModifiedDate!.toString()) !=
                  null)
                Text(
                  DateFormat('dd MMM yyyy hh:mm a').format(
                      DateTime.parse(content.lastModifiedDate!.toString())
                          .toLocal()),
                  style: secMed12.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              const SizedBox(width: appPadding),
              Icon(
                content.status == "Seen" ? Icons.done_all : Icons.check,
                size: 16,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
