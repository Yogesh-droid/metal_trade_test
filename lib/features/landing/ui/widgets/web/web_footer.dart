import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import '../../../../../core/constants/assets.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appWidgetGap),
      // width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Assets.assetsWelcomeWebBg), fit: BoxFit.fill),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          mission(context),
          const SizedBox(height: appWidgetGap * 2),
          Text("© MetalTrade 2023, All Rights Reserved",
              style: secMed12.copyWith(color: Colors.white))
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kDownloadApp,
              style: secMed20.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Nunito"),
            ),
            const SizedBox(height: appWidgetGap),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.asset(Assets.assetsWelcomeGooglePlayBadge),
              const SizedBox(width: appPadding * 2),
              Image.asset(Assets.assetsWelcomeAppstoreBadge)
            ])
          ],
        )
      ]),
    );
  }

  Widget mission(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset(Assets.assetsWelcomeAppLogoName, color: Colors.white),
      const SizedBox(height: appPadding),
      Text(kSteelTradeInIndonasia,
          style: secMed15.copyWith(color: Colors.white, fontFamily: "Nunito"))
    ]);
  }
}
