import 'package:flutter/material.dart';

class HomePageAppbarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  const HomePageAppbarBottom(
      {super.key,
      required this.tabList,
      required this.tabController,
      required this.onTap,
      this.newsString,
      this.isScrollable});
  final List<Tab> tabList;
  final TabController tabController;
  final Function(int) onTap;
  final bool? isScrollable;
  final String? newsString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            isScrollable: isScrollable ?? false,
            tabs: tabList,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            onTap: (value) {
              onTap(value);
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 200);
}
