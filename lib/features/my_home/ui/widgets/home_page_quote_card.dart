import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/ui/widgets/home_page_card_up_section.dart';

import '../../../../core/constants/strings.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../rfq/ui/widgets/home_card_itemlist_widget.dart';

class HomePageQuoteCard extends StatelessWidget {
  const HomePageQuoteCard(
      {super.key,
      this.itemList,
      this.uuid,
      this.country,
      this.content,
      required this.onBorderedBtnTapped,
      required this.onFilledBtnTapped,
      required this.borderedBtnTitle,
      required this.filledBtnTitle});
  final Content? content;
  final List<Item>? itemList;
  final String? uuid;
  final String? country;
  final Function()? onBorderedBtnTapped;
  final Function()? onFilledBtnTapped;
  final String? borderedBtnTitle;
  final String? filledBtnTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageCardUpSection(
                dateTime: content!.lastModifiedDate ?? '',
                uuidTitle: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '${content!.uuid}',
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed(myQuoteDetailPage, extra: content);
                        }),
                  const TextSpan(text: ' on '),
                  TextSpan(
                      text: '${content!.enquiry!.uuid}',
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pushNamed(enquiryDetailPageName,
                              extra: content,
                              queryParameters: {
                                'title': kEnquiryDetail.tr(),
                                'isMyEnquiry': 'yes',
                                'hideBtn': 'yes'
                              });
                        })
                ])),
                onDetailTapped: () {
                  context.pushNamed(myQuoteDetailPage, extra: content);
                },
              ),
              const Divider(),
              itemListWidget(context),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(children: [
                    Icon(
                      Icons.brightness_1,
                      color: content!.status == "Active"
                          ? Colors.green
                          : content!.status == "Expired"
                              ? Colors.red
                              : content!.status == "Inreview"
                                  ? Colors.orange
                                  : content!.status == "Complete"
                                      ? Colors.indigo
                                      : content!.status == "Closed"
                                          ? Colors.grey
                                          : Colors.blue[900],
                      size: 8,
                    ),
                    const SizedBox(width: appPadding),
                    Text(
                      content!.status ?? '',
                      style: secMed12.copyWith(
                          color: content!.status == "Active"
                              ? Colors.green
                              : content!.status == "Expired"
                                  ? Colors.red
                                  : content!.status == "Inreview"
                                      ? Colors.orange
                                      : content!.status == "Complete"
                                          ? Colors.indigo
                                          : content!.status == "Closed"
                                              ? Colors.grey
                                              : Colors.blue[900]),
                    )
                  ]),
                  const Spacer(),
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
            ],
          )),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: HomeCardItemListWidget(
          itemList: itemList,
          isQuote: true,
          onDetailTapped: () {
            context.pushNamed(myQuoteDetailPage, extra: content);
          }),
    );
  }

  Widget getItemListTile(Item e, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        e.sku!.title ?? '',
        style: secMed14.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      subtitle: Text(e.remarks ?? '',
          style: secMed12.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\$ ${e.price}",
            style: secMed14.copyWith(fontWeight: FontWeight.w700),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "${e.quantity} ",
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                children: [
                  TextSpan(
                      text: "${e.quantityUnit}",
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
