import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';

class HomePageCardUpSection extends StatelessWidget {
  const HomePageCardUpSection(
      {super.key,
      required this.dateTime,
      this.onDetailTapped,
      this.uuid,
      this.enquiryType,
      this.status,
      this.dateTimeTitle,
      this.uuidTitle});
  final String dateTime;
  final String? dateTimeTitle;
  final String? uuidTitle;
  final Function()? onDetailTapped;
  final String? uuid;
  final String? enquiryType;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dateTimeTitle != null
              ? Text(
                  dateTimeTitle ?? '',
                  style: secMed12.copyWith(
                      color: Theme.of(context).colorScheme.outline),
                )
              : DateTime.tryParse(dateTime) != null
                  ? Text(
                      "$kPosted: ${DateFormat('dd MMM yyyy - hh:mm a').format(DateTime.tryParse(dateTime)!)}",
                      style: secMed12.copyWith(
                          color: Theme.of(context).colorScheme.outline),
                    )
                  : const SizedBox(),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: onDetailTapped,
          )
        ],
      ),
      Row(
        children: [
          Text(
            uuidTitle ?? uuid ?? '',
            style: secMed12,
          ),
          const SizedBox(width: appPadding),
          if (enquiryType != null)
            Row(children: [
              Icon(Icons.brightness_1,
                  color: Theme.of(context).colorScheme.outline, size: 8),
              const SizedBox(width: appPadding),
              Text(
                enquiryType ?? '',
                style: secMed12.copyWith(
                    color: Theme.of(context).colorScheme.outline),
              )
            ]),
          const SizedBox(width: appPadding),
          if (status != null)
            Row(children: [
              Icon(
                Icons.brightness_1,
                color: status == "Active"
                    ? Colors.green
                    : status == "Expired"
                        ? Colors.red
                        : status == "Inreview"
                            ? Colors.orange
                            : status == "Complete"
                                ? Colors.indigo
                                : status == "Closed"
                                    ? Colors.grey
                                    : Colors.white,
                size: 8,
              ),
              const SizedBox(width: appPadding),
              Text(
                status ?? '',
                style: secMed12.copyWith(
                    color: status == "Active"
                        ? Colors.green
                        : status == "Expired"
                            ? Colors.red
                            : status == "Inreview"
                                ? Colors.orange
                                : status == "Complete"
                                    ? Colors.indigo
                                    : status == "Closed"
                                        ? Colors.grey
                                        : Colors.white),
              )
            ])
        ],
      ),
    ]);
  }
}
