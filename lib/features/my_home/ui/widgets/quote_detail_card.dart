import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import 'quote_list_item.dart';

class QuoteDetailCard extends StatelessWidget {
  const QuoteDetailCard(
      {super.key,
      required this.item,
      required this.uuid,
      this.filledBtnText,
      this.onFilledBtnTapped,
      this.onOutlinedBtnTapped,
      this.outlinedBtnText,
      this.lastDateModified,
      this.country});
  final List<Item> item;
  final String uuid;
  final String? filledBtnText;
  final Function()? onFilledBtnTapped;
  final Function()? onOutlinedBtnTapped;
  final String? outlinedBtnText;
  final String? lastDateModified;
  final String? country;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(uuid,
                  style: secMed12.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 2)),
              Text(
                  DateFormat("dd MMM yyyy - hh:mm a")
                      .format(DateTime.parse(lastDateModified!).toLocal()),
                  style: secMed12.copyWith(
                      color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(height: appFormFieldGap / 2),
              Text(country ?? '', style: secMed12)
            ]),
            const Spacer(),
            outlinedBtnText != null
                ? OutlinedButtonWidget(
                    title: outlinedBtnText!, onPressed: onOutlinedBtnTapped!)
                : const SizedBox(),
            const SizedBox(width: appPadding),
            filledBtnText != null
                ? FilledButtonWidget(
                    title: filledBtnText!, onPressed: onFilledBtnTapped!)
                : const SizedBox()
          ]),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Text(kProducts,
              style: secMed10.copyWith(
                  color: Theme.of(context).colorScheme.secondary)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding),
            child: Column(
                children: item.map((e) => QuoteListItem(item: e)).toList()))
      ]),
    );
  }
}
