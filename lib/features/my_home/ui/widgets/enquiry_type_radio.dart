import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';

import '../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';

class EnquiryTypeRadio extends StatelessWidget {
  const EnquiryTypeRadio(
      {super.key, required this.onSelect, required this.groupValue});
  final Function(String? value) onSelect;
  final String groupValue;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(
        children: [
          Radio<String>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: UserIntent.Buy.name,
              groupValue: groupValue,
              onChanged: onSelect),
          const Text(kBuy)
        ],
      ),
      const SizedBox(width: 40),
      Row(
        children: [
          Radio<String>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: UserIntent.Sell.name,
              groupValue: groupValue,
              onChanged: onSelect),
          const Text(kSell)
        ],
      )
    ]);
  }
}
