import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../profile/ui/widgets/bordered_textfield.dart';
import '../widgets/add_item_container.dart';
import '../widgets/enquiry_type_radio.dart';

class CreateEnquiryForm extends StatefulWidget {
  const CreateEnquiryForm({super.key});

  @override
  State<CreateEnquiryForm> createState() => _CreateEnquiryFormState();
}

class _CreateEnquiryFormState extends State<CreateEnquiryForm> {
  final TextEditingController cityTextController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deliveryTermsContriller = TextEditingController();
  final TextEditingController paymentTemsController = TextEditingController();
  final TextEditingController transportTermsController =
      TextEditingController();
  late List<ItemListContainer> itemContainers;

  @override
  void initState() {
    itemContainers = [
      ItemListContainer(
        onChange: (value) {},
        onProductSelect: (value) {},
        quantityController: quantityController,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Container(
        padding: const EdgeInsets.all(appPadding),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              kRfqType,
              style: secMed12,
            ),
            const EnquiryTypeRadio(),
            const SizedBox(height: appPadding),
            const SizedBox(height: appPadding),
            Column(children: itemContainers),
            TextButton(
                onPressed: () {
                  itemContainers.add(ItemListContainer(
                    onChange: (value) {},
                    onProductSelect: (value) {},
                    quantityController: quantityController,
                  ));
                  setState(() {});
                },
                child: const Text("+ $kAddProducts")),
            const SizedBox(height: appPadding),
            const Divider(),
            BorderedTextField(
                isObscureText: false,
                hintText: kAddDeliveryTerms,
                radius: 4,
                textEditingController: deliveryTermsContriller),
            const SizedBox(height: appPadding),
            BorderedTextField(
                isObscureText: false,
                hintText: kAddPaymentTerms,
                radius: 4,
                textEditingController: paymentTemsController),
            const SizedBox(height: appPadding),
            BorderedTextField(
                isObscureText: false,
                hintText: kTransportTerms,
                radius: 4,
                textEditingController: transportTermsController),
            const SizedBox(height: appPadding),
            BorderedTextField(
                isObscureText: false,
                hintText: kTellMoreAbtYourRequirement,
                maxLines: 4,
                radius: 4,
                textEditingController: descriptionController)
          ],
        ),
      ),
    );
  }
}
