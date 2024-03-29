import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import '../../../../core/constants/text_tyles.dart';

class QuoteListItem extends StatelessWidget {
  const QuoteListItem({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        item.sku!.title ?? '',
        style: secMed14.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(item.remarks ?? '',
          style: secMed12.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "\$ ${item.price}",
            style: secMed14.copyWith(fontWeight: FontWeight.w700),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "QTY ${item.quantity} ",
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                children: [
                  TextSpan(
                      text: "${item.quantityUnit}",
                      style: secMed12.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant))
                ]),
          ])),
        ],
      ),
    );
  }
}
