import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../text_tyles.dart';

class ContextMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContextMenuAppBar({super.key, this.title, this.actionButton});
  final String? title;
  final List<Widget>? actionButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title ?? ''),
        backgroundColor: blue,
        titleTextStyle: secMed18.copyWith(color: white),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: actionButton);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
