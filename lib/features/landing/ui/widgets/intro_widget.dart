import 'package:flutter/material.dart';

import '../../../../core/constants/text_tyles.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: secMed32.copyWith(
                  fontFamily: 'Nunito', fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            subtitle,
            style: secMed15.copyWith(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                color: const Color(0xFF838BA1)),
          ),
        )
      ],
    );
  }
}
