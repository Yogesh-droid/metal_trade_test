import 'package:flutter/material.dart';

import '../../../../core/constants/text_tyles.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle});
  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        Text(title, style: secMed15),
        Text(subtitle, style: secMed12)
      ],
    );
  }
}
