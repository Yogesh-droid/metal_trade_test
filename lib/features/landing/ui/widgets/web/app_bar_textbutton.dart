import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/text_tyles.dart';

class AppBarTextButton extends StatelessWidget {
  const AppBarTextButton(
      {super.key, required this.onPressed, required this.text});
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed(),
        child: Text(text,
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Nunito"))
            .tr());
  }
}
