import 'package:flutter/material.dart';

class HomePageAppbarBottom extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppbarBottom(
      {super.key,
      required this.tabList,
      required this.tabController,
      required this.onTap,
      this.newsString});
  final List<Tab> tabList;
  final TabController tabController;
  final Function(int) onTap;
  final String? newsString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   color: black,
        //   height: 30,
        //   child: Marquee(
        //       text: newsString ??
        //           'lskdmc;mdscmdwmcdm   sdockdsomc;ldwsmc;lmd   dspokewopkfipewjipodj  sdiocidsjipodj',
        //       style: const TextStyle(color: white),
        //       scrollAxis: Axis.horizontal),
        // ),
        TabBar(
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
