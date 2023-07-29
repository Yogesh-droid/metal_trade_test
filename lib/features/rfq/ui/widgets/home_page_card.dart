import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/ui/widgets/home_page_card_up_section.dart';
import 'package:metaltrade/features/rfq/ui/widgets/home_card_itemlist_widget.dart';

import '../../data/models/rfq_enquiry_model.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard(
      {super.key,
      this.itemList,
      this.uuid,
      this.country,
      this.content,
      required this.onBorderedBtnTapped,
      required this.onFilledBtnTapped,
      required this.borderedBtnTitle,
      required this.filledBtnTitle,
      this.onDetailTapped,
      this.enquiryType});
  final Content? content;
  final List<Item>? itemList;
  final String? uuid;
  final String? country;
  final String? enquiryType;
  final Function()? onBorderedBtnTapped;
  final Function()? onFilledBtnTapped;
  final Function()? onDetailTapped;
  final String? borderedBtnTitle;
  final String? filledBtnTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: appPadding * 2,
            left: appPadding * 2,
            right: appPadding * 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HomePageCardUpSection(
            dateTime: content!.lastModifiedDate ?? '',
            enquiryType: enquiryType,
            onDetailTapped: onDetailTapped,
            status: content!.status,
            uuid: content!.uuid,
          ),
          const Divider(),
          itemListWidget(context),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (borderedBtnTitle != null)
                OutlinedIconButtonWidget(
                  icon: const Icon(Icons.add),
                  title: borderedBtnTitle!,
                  onPressed: onBorderedBtnTapped ?? () {},
                ),
              const SizedBox(width: appPadding),
              if (filledBtnTitle != null)
                FilledButtonWidget(
                    title: filledBtnTitle!,
                    onPressed: onFilledBtnTapped ?? () {})
            ],
          )
        ]),
      ),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: HomeCardItemListWidget(
          itemList: itemList,
          onDetailTapped: () {
            onDetailTapped!();
          },
        ));
  }
}
