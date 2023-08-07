import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';

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
            child:
                CachedNetworkImage(imageUrl: content.body!.attachment ?? '')),
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
