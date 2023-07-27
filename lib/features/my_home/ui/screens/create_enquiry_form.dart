import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/data/models/post_enquiry_req_model.dart';
import 'package:metaltrade/features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/app_dropdown_form.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../../profile/ui/widgets/bordered_textfield.dart';
import '../../../profile/ui/widgets/kyc_dialog.dart';
import '../widgets/add_item_container.dart';
import '../widgets/enquiry_type_radio.dart';

const paymentTerms = [
  DropdownMenuItem<String>(value: 'ADVANCE', child: Text("Advance")),
  DropdownMenuItem<String>(
      value: 'AGAINST_LOADING', child: Text("Against loading")),
  DropdownMenuItem<String>(value: 'NEXT_DAY', child: Text("Next day")),
  DropdownMenuItem<String>(value: 'SAME_DAY', child: Text("Same day")),
  DropdownMenuItem<String>(
      value: 'WITHIN_7_DAYS', child: Text("Within 7 days")),
  DropdownMenuItem<String>(value: 'NO_TERMS', child: Text("No terms")),
];

const deliveryTerms = [
  DropdownMenuItem<String>(value: 'READY_STOCK', child: Text("Ready stock")),
  DropdownMenuItem<String>(
      value: 'WITHIN_7_DAYS', child: Text("Within 7 days")),
  DropdownMenuItem<String>(
      value: 'WITHIN_10_DAYS', child: Text("Within 10 days")),
  DropdownMenuItem<String>(value: 'NO_TERMS', child: Text("No terms")),
];

const transportationTerms = [
  DropdownMenuItem<String>(value: 'EX_FACTORY', child: Text("Ex factory")),
  DropdownMenuItem<String>(
      value: 'EX_SELLER_LOCATION', child: Text("Ex seller's location")),
  DropdownMenuItem<String>(
      value: 'FOR_BUYER_LOCATION', child: Text("F.O.R buyer's location")),
  DropdownMenuItem<String>(
      value: 'FOR_BUYER_LOCATION_FREIGHT_ON_ACTUAL',
      child: Text("F.O.R buyer's location (freight on actual)")),
  DropdownMenuItem<String>(value: 'NO_TERMS', child: Text("No terms")),
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
  final TextEditingController deliveryTermsContriller = TextEditingController();
  final TextEditingController paymentTemsController = TextEditingController();
  final TextEditingController transportTermsController =
      TextEditingController();
  late List<ItemListContainer> itemContainers;
  String groupValue = "Buy";
  String termsOfPayment = '';
  String termsOfDelivery = '';
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
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            if (state.profileEntity.company != null) {
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
                    ),
                    EnquiryTypeRadio(
                        onSelect: (value) {
                          groupValue = value!;
                          setState(() {});
                        },
                        groupValue: groupValue),
                    const SizedBox(height: appPadding * 2),
                    Column(children: itemContainers),
                    TextButton(
                        onPressed: () {
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
                                items[index]['quantity'] =
                                    int.parse(value.toString());
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
                        child: const Text("+ $kAddProducts")),
                    const SizedBox(height: appPadding),
                    const Divider(),
                    AppDropdownFormField(
                      hintText: kAddDeliveryTerms,
                      items: deliveryTerms,
                      onChange: (value) {
                        termsOfDelivery = value.toString();
                      },
                    ),
                    const SizedBox(height: appPadding),
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
                      maxLines: 4,
                      hintText: kRemarks,
                      textInputType: TextInputType.text,
                      focusNode: FocusNode(),
                    ),
                    const SizedBox(height: appWidgetGap - 20),
                    BlocBuilder<CreateEnquiryBloc, CreateEnquiryState>(
                      builder: (context, state) {
                        if (state is PostEnquiryInProgress) {
                          return const LoadingDots();
                        }
                        return FilledButtonIconWidget(
                          title: kCreateEnquiry,
                          onPressed: () {
                            postEnquiryMap['enquiryType'] = groupValue;
                            postEnquiryMap['transportationTerms'] =
                                termsOfTransport;
                            postEnquiryMap['paymentTerms'] = termsOfPayment;
                            postEnquiryMap['deliveryTerms'] = termsOfDelivery;
                            postEnquiryMap['item'] = items;
                            postEnquiryMap['remarks'] = remarksController.text;
                            PostEnquiryModel postEnquiryModel =
                                PostEnquiryModel.fromJson(postEnquiryMap);
                            context.read<CreateEnquiryBloc>().add(
                                PostEnquiryEvent(
                                    postEnquiryModel: postEnquiryModel));
                          },
                          icon: const Icon(Icons.add),
                          width: double.maxFinite,
                        );
                      },
                    )
                  ],
                ),
              );
            } else {
              return KycDialog(
                profileEntity: ProfileEntity(),
              );
            }
          } else if (state is ProfileFailed) {
            return const Center(
                child: Text("Something went wrong !! \n Profile not found",
                    textAlign: TextAlign.center));
          }
          return const SizedBox(
            child: Center(child: LoadingDots()),
          );
        },
      ),
    );
  }
}
