import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/strings.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart' as rfq_model;

class EnquiryCard extends StatelessWidget {
  const EnquiryCard({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.body!.enquiry!.uuid ?? '',
            style: secMed12.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const Divider(),
          Text(kProducts,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          const SizedBox(height: appPadding),
          ItemList(item: content.body!.enquiry!.item!),
          const SizedBox(height: appPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                  DateFormat('hh:mm a')
                      .format(DateTime.parse(content.lastModifiedDate!)),
                  style: secMed12.copyWith(
                      color: Theme.of(context).colorScheme.secondary)),
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

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.item});
  final List<rfq_model.Item> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: item
          .map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.sku!.title ?? '',
                          style:
                              secMed14.copyWith(fontWeight: FontWeight.w700)),
                      Text("${e.quantity} ${e.quantityUnit}")
                    ],
                  ),
                  Text(
                    e.remarks ?? '',
                    style: secMed12.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ))
          .toList(),
    );
  }
}