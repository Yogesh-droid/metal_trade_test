import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';

class EnquiryDetailHeading extends StatelessWidget {
  const EnquiryDetailHeading(
      {super.key,
      required this.datePosted,
      required this.status,
      required this.uuid});
  final String datePosted;
  final String status;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding * 2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DateTime.tryParse(datePosted) != null
            ? Text(
                "$kPosted : ${DateFormat('dd MMM yyyy - hh:mm a').format(DateTime.tryParse(datePosted)!)}",
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.secondary),
              )
            : const SizedBox(),
        Row(
          children: [
            Text(uuid,
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.secondary)),
            const SizedBox(width: appPadding),
            Row(children: [
              Icon(
                Icons.brightness_1,
                color: status == "Active"
                    ? Colors.green
                    : status == "Expired"
                        ? Colors.red
                        : status == "Inreview"
                            ? Colors.orange
                            : Colors.white,
                size: 8,
              ),
              const SizedBox(width: appPadding),
              Text(
                status,
                style: secMed12.copyWith(
                    color: status == "Active"
                        ? Colors.green
                        : status == "Expired"
                            ? Colors.red
                            : status == "Inreview"
                                ? Colors.orange
                                : Colors.white),
              )
            ])
          ],
        ),
      ]),
    );
  }
}
