import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';

class EnquiryDetailList extends StatelessWidget {
  final String paymentTerms;
  final String transportationTerms;
  final String deliveryTerms;
  final String? outlinedButtonText;
  final String? filledBtnText;
  final Function()? onOutlineTapped;
  final Function()? onFilledTapped;
  final List<Item> itemList;
  const EnquiryDetailList(
      {super.key,
      required this.paymentTerms,
      required this.transportationTerms,
      required this.deliveryTerms,
      this.outlinedButtonText,
      this.onOutlineTapped,
      this.onFilledTapped,
      this.filledBtnText,
      required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding * 2),
      child: Column(children: [
        itemListWidget(context),
        const SizedBox(height: appPadding),
        const Divider(),
        termsRow(context, kPaymentTerms, paymentTerms),
        const Divider(),
        termsRow(context, kTransportTerms, transportationTerms),
        const Divider(),
        termsRow(context, kDeliveryTerms, deliveryTerms),
        const SizedBox(height: appWidgetGap),
        Row(
          children: [
            outlinedButtonText != null
                ? Expanded(
                    child: OutlinedIconButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        title: kCloseRfq,
                        onPressed: onOutlineTapped!,
                        icon: const Icon(Icons.add)),
                  )
                : const SizedBox(),
            filledBtnText != null
                ? Expanded(
                    child: FilledButtonWidget(
                        title: filledBtnText!, onPressed: onFilledTapped!),
                  )
                : const SizedBox()
          ],
        )
      ]),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kProducts,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary)),
        getItemListTile(context),
      ],
    );
  }

  Widget getItemListTile(BuildContext context) {
    return Column(
        children: itemList
            .map((e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(e.sku!.title ?? '',
                      style: secMed14.copyWith(fontWeight: FontWeight.w700)),
                  subtitle: e.remarks != null
                      ? Text(
                          e.remarks ?? '',
                          style: secMed12.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                        )
                      : null,
                  trailing: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${e.quantity} ",
                        style: secMed12.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                        children: [
                          TextSpan(text: "${e.quantityUnit}", style: secMed12)
                        ]),
                  ])),
                ))
            .toList());
  }

  Widget termsRow(BuildContext context, String title, String? terms) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: secMed14.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            terms ?? '',
            textAlign: TextAlign.end,
          ))
    ]);
  }
}
