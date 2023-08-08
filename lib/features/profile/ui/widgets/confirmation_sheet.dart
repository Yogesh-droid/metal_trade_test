import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/text_tyles.dart';

class ConfirmationSheet extends StatelessWidget {
  const ConfirmationSheet(
      {super.key,
      required this.onConfirmaTapped,
      required this.title,
      this.explanation,
      this.height,
      required this.filledBtnText,
      required this.outlinedBtnText});
  final Function() onConfirmaTapped;
  final String title;
  final String? explanation;
  final double? height;
  final String filledBtnText;
  final String outlinedBtnText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(appPadding * 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(title,
                  style: secMed20.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Container(
                  padding: const EdgeInsets.all(appFormFieldGap),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      shape: BoxShape.circle),
                  child: const Icon(Icons.close)),
            )
          ]),
        ),
        const Divider(),
        const SizedBox(height: appPadding),
        Padding(
          padding: const EdgeInsets.all(appPadding * 2),
          child: Text(explanation ?? '',
              style: secMed18.copyWith(fontWeight: FontWeight.w400)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(appPadding * 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FilledButtonWidget(
                title: filledBtnText,
                onPressed: () {
                  onConfirmaTapped();
                },
                color: Colors.red[900]),
            OutlinedButtonWidget(
                title: outlinedBtnText,
                onPressed: () {
                  context.pop();
                })
          ]),
        )
      ]),
    );
  }
}
