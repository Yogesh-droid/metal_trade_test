import 'package:flutter/material.dart';

import '../../../../core/constants/text_tyles.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {super.key,
      required this.title,
      required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: secMed18.copyWith(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subtitle, style: secMed12),
        )
      ],
    );
  }
}
