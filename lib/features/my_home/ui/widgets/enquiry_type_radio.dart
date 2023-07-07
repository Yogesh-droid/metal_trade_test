import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/strings.dart';

import '../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';

class EnquiryTypeRadio extends StatefulWidget {
  const EnquiryTypeRadio({super.key});

  @override
  State<EnquiryTypeRadio> createState() => _EnquiryTypeRadioState();
}

class _EnquiryTypeRadioState extends State<EnquiryTypeRadio> {
  var rValue = UserIntent.Buy.name;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(
        children: [
          Radio<String>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: UserIntent.Buy.name,
              groupValue: rValue,
              onChanged: (value) {
                rValue = value!;
                setState(() {});
              }),
          const Text(kBuy)
        ],
      ),
      const SizedBox(width: 40),
      Row(
        children: [
          Radio<String>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: UserIntent.Sell.name,
              groupValue: rValue,
              onChanged: (value) {
                rValue = value!;
                setState(() {});
              }),
          const Text(kSell)
        ],
      )
    ]);
  }
}
