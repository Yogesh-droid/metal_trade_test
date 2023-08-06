import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';

class EnquiryDetailList extends StatelessWidget {
  final String paymentTermsDisplay;
  final String transportationTermsDisplay;
  final String? outlinedButtonText;
  final String? filledBtnText;
  final Function()? onOutlineTapped;
  final Function()? onFilledTapped;
  final List<Item> itemList;
  final String? otherTerms;
  const EnquiryDetailList(
      {super.key,
      required this.paymentTermsDisplay,
      required this.transportationTermsDisplay,
      this.outlinedButtonText,
      this.onOutlineTapped,
      this.onFilledTapped,
      this.filledBtnText,
      required this.itemList,
      this.otherTerms});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
      child: Column(children: [
        itemListWidget(context),
        const SizedBox(height: appPadding),
        const Divider(),
        termsRow(context, kPaymentTerms, paymentTermsDisplay),
        const Divider(),
        termsRow(context, kTransportTerms, transportationTermsDisplay),
        const Divider(),
        termsRow(context, kRemarks, otherTerms),
        const SizedBox(height: appWidgetGap),
        Row(
          children: [
            outlinedButtonText != null
                ? Expanded(
                    child: OutlinedIconButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        title: outlinedButtonText ?? '',
                        onPressed: onOutlineTapped!,
                        icon: const Icon(Icons.add)),
                  )
                : const SizedBox(),
            const SizedBox(width: appPadding * 2),
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
                .copyWith(color: Theme.of(context).colorScheme.secondary)).tr(),
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
