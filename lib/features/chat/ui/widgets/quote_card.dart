import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import 'enquiry_card.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.body!.quote!.uuid ?? '',
            style: secMed12.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const Divider(),
          Text(kProducts,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.outline)).tr(),
          const SizedBox(height: appPadding),
          ItemList(item: content.body!.quote!.item!, isQuote: true),
          const SizedBox(height: appPadding * 2),
          Row(
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
        ],
      ),
    );
  }
}
