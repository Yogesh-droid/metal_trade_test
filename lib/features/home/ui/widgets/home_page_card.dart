import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import '../../data/models/home_page_enquiry_model.dart';
import 'package:intl/intl.dart';

class HomePageCard extends StatefulWidget {
  const HomePageCard(
      {super.key,
      required this.isSeller,
      this.enquiryCommpanyName,
      this.companyAddress,
      this.ownerName,
      this.sellingFrom,
      this.datePosted,
      this.itemList});
  final bool isSeller;
  final String? enquiryCommpanyName;
  final String? companyAddress;
  final String? ownerName;
  final String? sellingFrom;
  final String? datePosted;
  final List<Item>? itemList;

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  bool isItemsCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text(
                    widget.enquiryCommpanyName ?? '',
                    style: secMed14.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.companyAddress ?? ''),
                ]),
                Column(children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.person)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message_outlined)),
                    ],
                  ),
                  Text(DateFormat('dd MMM yyyy')
                      .format(DateTime.parse(widget.datePosted ?? '')))
                ])
              ],
            ),
            const Divider(),
            Container(
                alignment: Alignment.topLeft,
                child: widget.isSeller
                    ? RichText(
                        text: TextSpan(
                            text: kWantsToSellFrom,
                            style:
                                secMed15.copyWith(fontWeight: FontWeight.bold),
                            children: [
                            TextSpan(text: " ${widget.sellingFrom ?? "All"}")
                          ]))
                    : RichText(
                        text: TextSpan(
                            text: kWantsTOBuyFrom,
                            style:
                                secMed15.copyWith(fontWeight: FontWeight.bold),
                            children: [
                            TextSpan(
                                text: " ${widget.sellingFrom ?? "All"}",
                                style: secMed14.copyWith(
                                    fontWeight: FontWeight.normal))
                          ]))),
            const Divider(),
            itemListWidget(context)
          ]),
        ),
      ),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kItemList,
            style: secMed14.copyWith(fontWeight: FontWeight.w600),
          ),
          Column(
              children: isItemsCollapsed
                  ? [getItemListTile(widget.itemList![0])]
                  : widget.itemList!.map((e) => getItemListTile(e)).toList()),
          TextButton(
              onPressed: () {
                isItemsCollapsed = !isItemsCollapsed;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  isItemsCollapsed ? kShowMore : kShowLess,
                ),
              ))
        ],
      ),
    );
  }

  Widget getItemListTile(Item e) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(e.sku!.title ?? ''),
      subtitle: Text(e.remarks ?? ''),
      trailing: RichText(
          text: TextSpan(children: [
        TextSpan(text: "${e.quantity} ", style: secMed12),
        TextSpan(text: "${e.quantityUnit}", style: secMed12)
      ])),
    );
  }
}
