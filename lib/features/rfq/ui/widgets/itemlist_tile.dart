import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import '../../../../core/constants/text_tyles.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key, required this.item, this.price, this.isQuote});
  final Item item;
  final int? price;
  final bool? isQuote;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        item.sku!.title ?? '',
        style: secMed14.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        item.remarks ?? '',
        style: secMed12.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isQuote != null)
            Text(
              "\$ $price",
              style: secMed14.copyWith(fontWeight: FontWeight.w700),
            ),
          isQuote != null
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: "QTY ${item.quantity} ",
                      style: secMed12.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      children: [
                        TextSpan(text: "${item.quantityUnit}", style: secMed12)
                      ]),
                ]))
              : RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: "${item.quantity} ",
                      style: secMed12.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      children: [
                        TextSpan(text: "${item.quantityUnit}", style: secMed12)
                      ]),
                ])),
        ],
      ),
    );
  }
}
