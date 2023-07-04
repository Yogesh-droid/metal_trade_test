import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.actions,
      this.title,
      this.elevation,
      this.bottomWidget,
      this.height,
      this.color});

  final List<Widget>? actions;
  final Widget? title;
  final double? elevation;
  final PreferredSizeWidget? bottomWidget;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: color,
      title: title,
      actions: actions,
      elevation: elevation,
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, height ?? 60);
}
