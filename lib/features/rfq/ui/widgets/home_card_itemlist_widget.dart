import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/ui/widgets/itemlist_tile.dart';

import '../../../../core/constants/strings.dart';
import '../../data/models/rfq_enquiry_model.dart';

class HomeCardItemListWidget extends StatelessWidget {
  const HomeCardItemListWidget(
      {super.key, required this.itemList, this.onDetailTapped});
  final List<Item>? itemList;
  final Function()? onDetailTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kProducts,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ItemListTile(item: itemList![0]),
          if (itemList!.length > 1)
            TextButton(
                onPressed: onDetailTapped,
                child: Text("+ ${itemList!.length - 1} more"))
        ],
      ),
    );
  }
}
