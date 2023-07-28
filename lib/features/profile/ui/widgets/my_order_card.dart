import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../my_home/ui/widgets/quote_list_item.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../data/models/my_order_model.dart' as order_model;

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({super.key, this.content, this.itemList, this.uuid});

  final order_model.Content? content;
  final List<Item>? itemList;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: appPadding * 2),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
          padding: const EdgeInsets.all(appPadding * 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTime.tryParse(content!.lastModifiedDate ?? '') != null
                    ? Text(
                        "${content!.uuid} on: ${DateFormat('dd MMM yyyy - hh:mm a').format(DateTime.tryParse(content!.lastModifiedDate ?? '')!)}",
                        style: secMed12.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    : const SizedBox()
              ],
            ),
            Row(
              children: [
                Text(
                  "${content!.quote!.uuid} on ${content!.enquiry!.uuid}",
                  style: secMed12,
                ),
              ],
            ),
            const Divider(),
            itemListWidget(context),
            const Divider(),
            Row(children: [
              Icon(
                Icons.brightness_1,
                color: content!.status == "Active"
                    ? Colors.green
                    : content!.status == "Expired"
                        ? Colors.red
                        : content!.status == "Inreview"
                            ? Colors.orange
                            : Colors.blue[900],
                size: 8,
              ),
              const SizedBox(width: appPadding),
              Text(
                content!.status ?? '',
                style: secMed12.copyWith(
                    color: content!.status == "Active"
                        ? Colors.green
                        : content!.status == "Expired"
                            ? Colors.red
                            : content!.status == "Inreview"
                                ? Colors.orange
                                : Colors.blue[900]),
              ),
              const Spacer(),
              Text("\$ ${content!.totalValue}",
                  style: secMed15.copyWith(fontWeight: FontWeight.w800))
            ]),
          ])),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kProducts,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.outline)),
          Column(
              children: itemList!.map((e) => QuoteListItem(item: e)).toList())
        ],
      ),
    );
  }
}
