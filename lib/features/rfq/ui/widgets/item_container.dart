import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/controllers/select_product_to_quote_cubit/select_product_to_quote_cubit.dart';

class ItemContainer extends StatefulWidget {
  const ItemContainer(
      {super.key,
      required this.item,
      this.onChange,
      required this.onPriceChange,
      required this.onQuantityChange});
  final Item item;
  final Function(Object? object)? onChange;
  final Function(String s) onPriceChange;
  final Function(String s) onQuantityChange;

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  late SelectProductToQuoteCubit selectProductToQuoteCubit;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late String initialPrice;
  late String initialQuantity;

  @override
  void initState() {
    selectProductToQuoteCubit = context.read<SelectProductToQuoteCubit>();
    initialPrice = "${0}";
    initialQuantity = "${widget.item.quantity}";
    selectProductToQuoteCubit.quantity = widget.item.quantity ?? 0;
    selectProductToQuoteCubit.price = 0;
    quantityController = TextEditingController(text: initialQuantity);
    priceController = TextEditingController(text: initialPrice);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      color: Theme.of(context).colorScheme.tertiaryContainer,
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
                textInputType: TextInputType.number,
                isObscureText: false,
                textEditingController: quantityController,
                onChange: widget.onQuantityChange,
                hintText: "${kQuantity.tr()} (${widget.item.quantityUnit})",
              )),
              const SizedBox(width: appPadding),
              Expanded(
                  child: BorderedTextField(
                textInputType: TextInputType.number,
                isObscureText: false,
                textEditingController: priceController,
                onChange: widget.onPriceChange,
                hintText: "${kQuotePrice.tr()} (\$)",
              ))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
