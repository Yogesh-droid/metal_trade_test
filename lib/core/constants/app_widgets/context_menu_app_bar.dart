import 'package:flutter/material.dart';

class ContextMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContextMenuAppBar({super.key, this.title, this.actionButton});
  final String? title;
  final List<Widget>? actionButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title ?? ''),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: actionButton);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
