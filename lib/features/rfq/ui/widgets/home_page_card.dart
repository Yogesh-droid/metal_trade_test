import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import '../../data/models/rfq_enquiry_model.dart';
import 'package:intl/intl.dart';

class HomePageCard extends StatefulWidget {
  const HomePageCard(
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
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTime.tryParse(widget.content!.lastModifiedDate ?? '') !=
                        null
                    ? Text(
                        "$kPosted : ${DateFormat('dd MMM yyyy').format(DateTime.tryParse(widget.content!.lastModifiedDate ?? '')!)}",
                        style: secMed12.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    : const SizedBox(),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    context.pushNamed(productDetailPageRouteName,
                        extra: widget.content);
                  },
                )
              ],
            ),
            Row(
              children: [
                Text(widget.uuid ?? ''),
                const SizedBox(width: appPadding),
                Row(children: [
                  Icon(
                    Icons.brightness_1,
                    color: widget.content!.status == "Active"
                        ? Colors.green
                        : widget.content!.status == "Expired"
                            ? Colors.red
                            : widget.content!.status == "Inreview"
                                ? Colors.orange
                                : Colors.white,
                    size: 8,
                  ),
                  const SizedBox(width: appPadding),
                  Text(
                    widget.content!.status ?? '',
                    style: secMed12.copyWith(
                        color: widget.content!.status == "Active"
                            ? Colors.green
                            : widget.content!.status == "Expired"
                                ? Colors.red
                                : widget.content!.status == "Inreview"
                                    ? Colors.orange
                                    : Colors.white),
                  )
                ])
              ],
            ),
            const Divider(),
            itemListWidget(context),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.borderedBtnTitle != null)
                  OutlinedIconButtonWidget(
                    icon: const Icon(Icons.add),
                    title: widget.borderedBtnTitle!,
                    onPressed: widget.onBorderedBtnTapped ?? () {},
                  ),
                const SizedBox(width: appPadding),
                if (widget.filledBtnTitle != null)
                  FilledButtonWidget(
                      title: widget.filledBtnTitle!,
                      onPressed: widget.onFilledBtnTapped ?? () {})
              ],
            )
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
          Text(kProducts,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          getItemListTile(widget.itemList![0]),
          if (widget.itemList!.length > 1)
            TextButton(
                onPressed: () {
                  context.pushNamed(productDetailPageRouteName,
                      extra: widget.content);
                },
                child: Text("+ ${widget.itemList!.length} more"))
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
        TextSpan(
            text: "${e.quantity} ",
            style: secMed12.copyWith(
                color: Theme.of(context).colorScheme.onSurface),
            children: [TextSpan(text: "${e.quantityUnit}", style: secMed12)]),
      ])),
    );
  }
}
