import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../data/models/chat_response_model.dart';

class TextChatCard extends StatelessWidget {
  const TextChatCard({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content.body!.text ?? ''),
          const SizedBox(height: appPadding),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (DateTime.tryParse(content.lastModifiedDate!.toString()) !=
                    null)
                  Text(
                    DateFormat('dd MMM yyyy hh:mm a').format(
                        DateTime.parse(content.lastModifiedDate!.toString())),
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
        ],
      ),
    );
  }
}
