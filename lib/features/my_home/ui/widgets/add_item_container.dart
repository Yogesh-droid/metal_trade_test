import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/data/models/sku_model.dart';
import 'package:metaltrade/features/my_home/ui/widgets/sku_container.dart';

class ItemListContainer extends StatefulWidget {
  const ItemListContainer({super.key, required this.skuList});
  final List<Content> skuList;

  @override
  State<ItemListContainer> createState() => _ItemListContainerState();
}

class _ItemListContainerState extends State<ItemListContainer> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedUnit = 'MT';
  String selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return SkuContainer(onSelected: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        });
                      });
                },
                child: Row(children: [
                  Text(selectedItem.isEmpty ? kItemName : selectedItem),
                  const SizedBox(width: 15),
                  const Icon(Icons.arrow_drop_down_rounded)
                ]),
              ),
              const SizedBox(width: 15),
              Expanded(
                  child: TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(hintText: kQuantity),
              )),
              DropdownButton(
                  items: [
                    DropdownMenuItem<String>(
                        value: 'MT', child: const Text("MT"), onTap: () {}),
                    DropdownMenuItem<String>(
                      value: 'T',
                      child: const Text("T"),
                      onTap: () {},
                    ),
                    DropdownMenuItem<String>(
                      value: 'KG',
                      child: const Text("KG"),
                      onTap: () {},
                    ),
                    DropdownMenuItem<String>(
                      value: 'G',
                      child: const Text("G"),
                      onTap: () {},
                    ),
                  ],
                  onChanged: (value) {
                    selectedUnit = value!;
                    setState(() {});
                  },
                  value: selectedUnit,
                  hint: const Text(kItemName)),
            ],
          ),
          TextFormField(
            controller: descriptionController,
            decoration:
                const InputDecoration(hintText: kTellMoreAbtYourRequirement),
          )
        ],
      ),
    );
  }
}
