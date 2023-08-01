import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/data/models/sku_model.dart';
import 'package:metaltrade/features/my_home/ui/widgets/app_dropdown_form.dart';
import 'package:metaltrade/features/my_home/ui/widgets/sku_container.dart';
import 'package:metaltrade/features/profile/ui/widgets/bordered_textfield.dart';
import 'package:metaltrade/features/profile/ui/widgets/disabled_text_field.dart';

class ItemListContainer extends StatefulWidget {
  const ItemListContainer(
      {super.key,
      this.onChange,
      required this.onProductSelect,
      this.onDone,
      this.onRemoveTapped,
      this.onRemarksSubmit});
  final Function(Object? value)? onChange;
  final Function(Content content) onProductSelect;
  final Function(String s)? onDone;
  final Function(String s)? onRemarksSubmit;
  final Function()? onRemoveTapped;

  @override
  State<ItemListContainer> createState() => _ItemListContainerState();
}

class _ItemListContainerState extends State<ItemListContainer> {
  Content selectedSku = Content();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final FocusNode quantityFocusNode = FocusNode();
  @override
  void initState() {
    quantityFocusNode.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: widget.onRemoveTapped == null
              ? EdgeInsets.zero
              : const EdgeInsets.only(top: 24),
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
                          Navigator.pop(context);
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
                    onChange: widget.onDone,
                    focusNode: FocusNode(),
                  )),
                  const SizedBox(width: 5),
                  Expanded(
                      child: AppDropdownFormField(
                    hintText: kUnit,
                    items: const [
                      DropdownMenuItem<String>(value: 'MT', child: Text("MT")),
                      DropdownMenuItem<String>(value: 'Kg', child: Text("KG")),
                    ],
                    onChange: widget.onChange,
                  ))
                ],
              ),
              const SizedBox(height: appPadding),
              BorderedTextField(
                isObscureText: false,
                textEditingController: remarksController,
                radius: 4,
                hintText: kProductRemarks,
                textInputType: TextInputType.text,
                onChange: widget.onRemarksSubmit,
                focusNode: FocusNode(),
              ),
              const SizedBox(height: appPadding * 2)
            ],
          ),
        ),
        if (widget.onRemoveTapped != null)
          Positioned(
              right: 0,
              child: InkWell(
                onTap: () {
                  widget.onRemoveTapped!();
                },
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ))
      ],
    );
  }
}
