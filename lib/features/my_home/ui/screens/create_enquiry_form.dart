import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/data/models/post_enquiry_req_model.dart';
import 'package:metaltrade/features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/app_dropdown_form.dart';
import 'package:metaltrade/features/my_home/ui/widgets/attachment_box.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../profile/ui/widgets/bordered_textfield.dart';
import '../widgets/add_item_container.dart';
import '../widgets/enquiry_type_radio.dart';

const paymentTerms = [
  DropdownMenuItem<String>(value: 'OTHERS', child: Text("Others")),
  DropdownMenuItem<String>(value: 'LC_AT_SITE', child: Text("LC at site")),
  DropdownMenuItem<String>(value: 'ADVANCE', child: Text("Advance"))
];

const transportationTerms = [
  DropdownMenuItem<String>(
      value: 'CIF', child: Text("CIF (Cost, Freight and Insurance)")),
  DropdownMenuItem<String>(value: 'OTHERS', child: Text("Others")),
  DropdownMenuItem<String>(value: 'FOB', child: Text("FOB (Freight on Board)")),
  DropdownMenuItem<String>(value: 'CFR', child: Text("CFR (Cost and Freight)")),
];

class CreateEnquiryForm extends StatefulWidget {
  const CreateEnquiryForm({super.key});

  @override
  State<CreateEnquiryForm> createState() => _CreateEnquiryFormState();
}

class _CreateEnquiryFormState extends State<CreateEnquiryForm> {
  final TextEditingController cityTextController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController paymentTermsController = TextEditingController();
  final TextEditingController transportTermsController =
      TextEditingController();
  late List<ItemListContainer> itemContainers;
  String groupValue = "Buy";
  String termsOfPayment = '';
  String termsOfTransport = '';
  String remarks = '';
  int selectedProductSku = 0;
  int itemCOntainerKey = 0;
  Map<String, dynamic> postEnquiryMap = {};
  List<Map<String, dynamic>> items = [];
  @override
  void initState() {
    items.add({});
    itemContainers = [
      ItemListContainer(
        key: ValueKey(itemCOntainerKey),
        onChange: (value) {
          items[0]['quantityUnit'] = value!;
        },
        onProductSelect: (value) {
          items[0]['sku'] = {"id": value.id};
        },
        onDone: (value) {
          if (value.isNotEmpty) {
            items[0]['quantity'] = int.parse(value.toString());
          }
        },
        onRemarksSubmit: (value) {
          items[0]['remarks'] = value;
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            kEnquiryType,
            style: secMed12,
          ).tr(),
          EnquiryTypeRadio(
              onSelect: (value) {
                groupValue = value!;
                setState(() {});
              },
              groupValue: groupValue),
          const SizedBox(height: appPadding),
          Column(children: itemContainers),
          InkWell(
              onTap: () {
                itemCOntainerKey++;
                items.add({});
                int index = itemContainers.length;
                itemContainers.add(ItemListContainer(
                  key: ValueKey(itemCOntainerKey),
                  onChange: (value) {
                    items[index]['quantityUnit'] = value!;
                  },
                  onProductSelect: (value) {
                    items[index]['sku'] = {"id": value.id};
                  },
                  onDone: (value) {
                    if (value.isNotEmpty) {
                      items[index]['quantity'] = int.parse(value.toString());
                    }
                  },
                  onRemarksSubmit: (value) {
                    items[index]['remarks'] = value;
                  },
                  onRemoveTapped: () {
                    itemContainers.remove(itemContainers[index]);
                    items.remove(items[index]);
                    setState(() {});
                  },
                ));
                setState(() {});
              },
              child: Text(
                "+ $kAddProducts",
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.primary),
              ).tr()),
          const Divider(),
          AppDropdownFormField(
            hintText: kAddPaymentTerms,
            items: paymentTerms,
            onChange: (value) {
              termsOfPayment = value.toString();
            },
          ),
          const SizedBox(height: appPadding),
          AppDropdownFormField(
            hintText: kAddTransportTerms,
            items: transportationTerms,
            onChange: (value) {
              termsOfTransport = value.toString();
            },
          ),
          const SizedBox(height: appPadding),
          BorderedTextField(
            isObscureText: false,
            textEditingController: remarksController,
            radius: 4,
            maxLines: 2,
            hintText: kOtherTerms,
            textInputType: TextInputType.text,
            focusNode: FocusNode(),
          ),
          const SizedBox(height: appPadding),
          const AttachmentBox(),
          const Divider(),
          BlocBuilder<CreateEnquiryBloc, CreateEnquiryState>(
            builder: (context, state) {
              if (state is PostEnquiryInProgress) {
                return const LoadingDots();
              }
              return FilledButtonIconWidget(
                title: kCreateEnquiry,
                onPressed: () {
                  postEnquiryMap['enquiryType'] = groupValue;
                  postEnquiryMap['transportationTerms'] = termsOfTransport;
                  postEnquiryMap['paymentTerms'] = termsOfPayment;
                  postEnquiryMap['otherAttachmentsUrl'] =
                      context.read<CreateEnquiryBloc>().url ?? '';
                  postEnquiryMap['item'] = items;
                  postEnquiryMap['remarks'] = remarksController.text;
                  PostEnquiryModel postEnquiryModel =
                      PostEnquiryModel.fromJson(postEnquiryMap);
                  context.read<CreateEnquiryBloc>().add(
                      PostEnquiryEvent(postEnquiryModel: postEnquiryModel));
                },
                icon: const Icon(Icons.add),
                width: double.maxFinite,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
