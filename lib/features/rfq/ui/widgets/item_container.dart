import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

class ItemContainer extends StatefulWidget {
  const ItemContainer({super.key, required this.item, this.onChange});
  final Item item;
  final Function(Object? object)? onChange;

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late String initialPrice;
  late String initialQuantity;

  @override
  void initState() {
    initialPrice = "\$ ${widget.item.price}";
    initialQuantity = "${widget.item.quantity} ${widget.item.quantityUnit}";
    quantityController = TextEditingController(text: initialQuantity);
    priceController = TextEditingController(text: initialPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.item.sku!.title ?? '',
                  style: secMed14.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onBackground)),
              Checkbox(value: true, onChanged: widget.onChange)
            ],
          ),
          Text(
            widget.item.remarks ?? '',
            style:
                secMed12.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
          const SizedBox(height: appPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: BorderedTextField(
                isObscureText: false,
                textEditingController: quantityController,
                hintText: kQuantity,
              )),
              const SizedBox(width: appPadding),
              Expanded(
                  child: BorderedTextField(
                isObscureText: false,
                textEditingController: priceController,
                hintText: kQuotePrice,
              ))
            ],
          )
        ],
      ),
    );
  }
}
