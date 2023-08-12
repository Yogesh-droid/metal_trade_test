import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/rfq/ui/widgets/itemlist_tile.dart';

import '../../../../core/constants/strings.dart';
import '../../data/models/rfq_enquiry_model.dart';

class HomeCardItemListWidget extends StatelessWidget {
  const HomeCardItemListWidget(
      {super.key, required this.itemList, this.onDetailTapped, this.isQuote});
  final List<Item>? itemList;
  final Function()? onDetailTapped;
  final bool? isQuote;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kProducts.tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.outline)),
          ItemListTile(
              item: itemList![0],
              price: itemList![0].price!.toInt(),
              isQuote: isQuote),
          if (itemList!.length > 1)
            InkWell(
                onTap: () {
                  onDetailTapped!();
                },
                child: Text(
                  "+ ${itemList!.length - 1} more",
                  style: secMed14.copyWith(
                      color: Theme.of(context).colorScheme.primary),
                ))
        ],
      ),
    );
  }
}
