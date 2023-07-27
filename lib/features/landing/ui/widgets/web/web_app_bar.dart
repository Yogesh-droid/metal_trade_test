import 'package:flutter/material.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/spaces.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WebAppBar({super.key, required this.actions});
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: appWidgetGap,
      title: Image.asset(Assets.assetsWelcomeAppLogoName),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 100);
}
