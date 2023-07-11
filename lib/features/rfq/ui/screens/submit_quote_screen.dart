import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/item_container.dart';
import 'package:metaltrade/features/rfq/ui/widgets/total_price_box.dart';

class SubmitQuoteScreen extends StatefulWidget {
  const SubmitQuoteScreen({super.key, required this.content});
  final Content content;

  @override
  State<SubmitQuoteScreen> createState() => _SubmitQuoteScreenState();
}

class _SubmitQuoteScreenState extends State<SubmitQuoteScreen> {
  List<int> selectedIndex = [];
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ContextMenuAppBar(title: kSubmitQuote, subtitle: widget.content.uuid),
      body: SingleChildScrollView(
        child: _buildPanel(),
      ),
      floatingActionButton: TotalPriceBox(
          onPressed: () {
            List<Map<String, dynamic>> selectedItems = [];
            for (var element in widget.content.item!) {
              if (selectedIndex.contains(element.id)) {
                // TODO : Getting value of edited price and quantity
                selectedItems.add({
                  "quantity": element.quantity,
                  "quantityUnit": element.quantityUnit,
                  "price": element.price,
                  "remarks": element.remarks,
                  "sku": {"id": element.sku!.id}
                });
              }
            }
          },
          price: totalPrice),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: widget.content.item!
          .map((e) => AnimatedSize(
                duration: const Duration(milliseconds: 500),
                child: selectedIndex.contains(e.id)
                    ? ItemContainer(
                        item: e,
                        onChange: (value) {
                          setState(() {
                            selectedIndex.contains(e.id)
                                ? selectedIndex.remove(e.id)
                                : selectedIndex.add(e.id!);
                            totalPrice -= e.price!;
                          });
                        })
                    : CheckboxListTile(
                        title: Text(e.sku!.title ?? '',
                            style:
                                secMed14.copyWith(fontWeight: FontWeight.w700)),
                        subtitle: Text(
                          e.remarks ?? '',
                          style: secMed12.copyWith(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        value: false,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex.contains(e.id)
                                ? selectedIndex.remove(e.id)
                                : selectedIndex.add(e.id!);
                            totalPrice += e.price!;
                          });
                        }),
              ))
          .toList(),
    );
  }
}
