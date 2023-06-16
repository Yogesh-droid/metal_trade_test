import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_colors.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
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
      shadowColor: grey7,
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
