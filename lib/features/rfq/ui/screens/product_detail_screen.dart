import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';
import '../../data/models/rfq_enquiry_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.item});
  final Content item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        appBar: const ContextMenuAppBar(title: kEnquiryDetail),
        body: SingleChildScrollView(
            child: Container(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DateTime.tryParse(item.lastModifiedDate ?? '') != null
                  ? Text(
                      "$kPosted : ${DateFormat('dd MMM yyyy - hh:mm a').format(DateTime.tryParse(item.lastModifiedDate ?? '')!)}",
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  : const SizedBox(),
              Text(
                '${item.uuid ?? ''}, ${item.enquiryCompany!.country!.name ?? ''}',
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const Divider(),
              itemListWidget(context),
              const SizedBox(height: appWidgetGap),
              const Divider(),
              termsRow(context, kPaymentTerms, item.paymentTerms),
              const Divider(),
              termsRow(context, kTransportTerms, item.transportationTerms),
              const Divider(),
              termsRow(context, kDeliveryTerms, item.deliveryTerms),
              const SizedBox(height: appWidgetGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedIconButtonWidget(
                    icon: const Icon(Icons.add),
                    title: kChat,
                    onPressed: () {},
                  ),
                  const SizedBox(width: appPadding),
                  FilledButtonWidget(
                    title: kSubmit,
                    onPressed: () {},
                  )
                ],
              )
            ]),
          ),
        )));
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
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          getItemListTile(context, item.item!),
        ],
      ),
    );
  }

  Widget getItemListTile(BuildContext context, List<Item> itemList) {
    return Column(
        children: itemList
            .map((e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(e.sku!.title ?? '',
                      style: secMed14.copyWith(fontWeight: FontWeight.w700)),
                  subtitle: Text(
                    e.remarks ?? '',
                    style: secMed12.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
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
      Text(terms ?? '')
    ]);
  }
}
