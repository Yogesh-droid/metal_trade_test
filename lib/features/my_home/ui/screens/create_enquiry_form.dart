import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/get_sku/get_sku_bloc.dart';
import '../widgets/add_item_container.dart';
import '../widgets/enquiry_type_radio.dart';

class CreateEnquiryForm extends StatelessWidget {
  CreateEnquiryForm({super.key});
  final TextEditingController cityTextController = TextEditingController();
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
            BlocBuilder<GetSkuBloc, GetSkuState>(
              builder: (context, state) {
                if (state is AllSkuFetched) {
                  return ItemListContainer(skuList: state.skuList);
                }
                return const ItemListContainer(skuList: []);
              },
            )
          ],
        ),
      ),
    );
  }
}
