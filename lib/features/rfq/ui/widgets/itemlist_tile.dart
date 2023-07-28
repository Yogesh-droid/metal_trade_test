import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import '../../../../core/constants/text_tyles.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.sku!.title ?? ''),
      subtitle: Text(item.remarks ?? ''),
      trailing: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "${item.quantity} ",
            style: secMed12.copyWith(
                color: Theme.of(context).colorScheme.onSurface),
            children: [
              TextSpan(text: "${item.quantityUnit}", style: secMed12)
            ]),
      ])),
    );
  }
}
