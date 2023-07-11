import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';

class TotalPriceBox extends StatelessWidget {
  const TotalPriceBox(
      {super.key, required this.price, required this.onPressed});
  final double price;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: appPadding * 3),
      child: Container(
        padding: const EdgeInsets.all(appPadding),
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text(kTotalOffer), Text("\$ $price")]),
              FilledButtonWidget(title: kSubmit, onPressed: onPressed)
            ]),
      ),
    );
  }
}
