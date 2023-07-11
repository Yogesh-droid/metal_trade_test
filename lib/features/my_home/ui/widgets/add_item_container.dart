import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/data/models/sku_model.dart';
import 'package:metaltrade/features/my_home/ui/widgets/app_dropdown_form.dart';
import 'package:metaltrade/features/my_home/ui/widgets/sku_container.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import 'package:metaltrade/features/profile/ui/widgets/disabled_text_field.dart';
import 'package:dotted_border/dotted_border.dart';

class ItemListContainer extends StatefulWidget {
  const ItemListContainer(
      {super.key,
      this.onChange,
      required this.quantityController,
      required this.onProductSelect,
      this.onDone});
  final Function(Object? value)? onChange;
  final TextEditingController quantityController;
  final Function(Content content) onProductSelect;
  final Function(String s)? onDone;

  @override
  State<ItemListContainer> createState() => _ItemListContainerState();
}

class _ItemListContainerState extends State<ItemListContainer> {
  Content selectedSku = Content();
  final TextEditingController quantityController = TextEditingController();
  final FocusNode quantityFocusNode = FocusNode();
  @override
  void initState() {
    quantityFocusNode.addListener(() {
      print(quantityFocusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.outline,
      padding: const EdgeInsets.all(appPadding),
      borderPadding: const EdgeInsets.only(bottom: appPadding),
      child: Column(
        children: [
          DisabledTextField(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return SkuContainer(onSelected: (value) {
                      selectedSku = value;
                      widget.onProductSelect(value);
                      setState(() {});
                    });
                  });
            },
            hintText: selectedSku.title ?? kItemName,
            suffix: Icon(
              CupertinoIcons.chevron_down,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          const SizedBox(height: appPadding),
          Row(
            children: [
              Expanded(
                  child: BorderedTextField(
                isObscureText: false,
                textEditingController: quantityController,
                radius: 4,
                hintText: kQuantity,
                textInputType: const TextInputType.numberWithOptions(),
                onDone: widget.onDone,
                focusNode: FocusNode(),
              )),
              const SizedBox(width: 5),
              Expanded(
                  child: AppDropdownFormField(
                hintText: kUnit,
                items: const [
                  DropdownMenuItem<String>(value: 'MT', child: Text("MT")),
                  DropdownMenuItem<String>(value: 'T', child: Text("T")),
                  DropdownMenuItem<String>(value: 'Kg', child: Text("KG")),
                ],
                onChange: widget.onChange,
              ))
            ],
          ),
          const SizedBox(height: appPadding * 2)
        ],
      ),
    );
  }
}
