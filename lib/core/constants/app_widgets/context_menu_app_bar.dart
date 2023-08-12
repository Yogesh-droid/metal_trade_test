import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

class ContextMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContextMenuAppBar(
      {super.key, this.title, this.actionButton, this.subtitle});
  final String? title;
  final String? subtitle;
  final List<Widget>? actionButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? '').tr(),
            Text(
              subtitle ?? '',
              style: secMed12.copyWith(
                  color: Theme.of(context).colorScheme.outline),
            ).tr()
          ],
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        actions: actionButton);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
