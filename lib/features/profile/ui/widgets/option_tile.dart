import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

class OptionTile extends StatelessWidget {
  const OptionTile(
      {Key? key, required this.title, this.leading, this.trailing, this.onTap})
      : super(key: key);
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () {
      //   onTap!();
      // },
      title: Text(title, style: secMed14.copyWith(fontWeight: FontWeight.w700)),
      leading: leading,
      trailing: trailing ?? const Icon(Icons.chevron_right),
    );
  }
}
