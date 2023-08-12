import 'package:easy_localization/easy_localization.dart';
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
      this.uuidTitle,
      this.country});
  final String dateTime;
  final String? dateTimeTitle;
  final Widget? uuidTitle;
  final Function()? onDetailTapped;
  final String? uuid;
  final String? enquiryType;
  final String? status;
  final String? country;

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
                      "${kPosted.tr()}: ${DateFormat('dd MMM yyyy - hh:mm a').format(DateTime.tryParse(dateTime)!.toLocal())}",
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
          if (uuidTitle != null) uuidTitle!,
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
          if (status != null && country == null)
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
              country == null
                  ? Text(
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
                  : const SizedBox.shrink(),
            ]),
          if (country != null)
            Text(
              country!,
              style: secMed12.copyWith(),
            )
        ],
      ),
    ]);
  }
}
