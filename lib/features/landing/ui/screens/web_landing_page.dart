import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/landing/ui/widgets/web/web_footer.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/routes/routes.dart';
import '../widgets/web/need_more_info.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: appWidgetGap,
        title: Image.asset(Assets.assetsWelcomeAppLogoName),
        actions: [
          appBarTextButton(context, kFeatures, () {
            scrollController.animateTo(MediaQuery.of(context).size.height / 1.5,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 500));
          }),
          appBarTextButton(context, kHowToUse, () {
            scrollController.animateTo(MediaQuery.of(context).size.height * 1.8,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 700));
          }),
          appBarTextButton(context, kReachUs, () {
            scrollController.animateTo(MediaQuery.of(context).size.height * 3,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 1000));
          }),
          FilledButtonWidget(
              title: kMyAcc,
              onPressed: () async {
                await LocalStorage.instance.getToken().then((value) {
                  if (value.isEmpty) {
                    context.go(landingPageRoute);
                  } else {
                    debugPrint("token is =>=>=>=>  $value");
                    context.go(dashBoardRoute);
                  }
                });
              }),
          const SizedBox(width: appWidgetGap)
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: appFormFieldGap * 3),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: appWidgetGap, right: appWidgetGap / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kTradeOn,
                                  style: secMed48.copyWith(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(kAllProductOfSteel,
                                    style: secMed48.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w800))
                              ]),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text(
                              kOurOneStop,
                              style: secMed18.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                          const SizedBox(height: appWidgetGap),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                    Assets.assetsWelcomeGooglePlayBadge),
                                const SizedBox(width: appPadding * 2),
                                Image.asset(Assets.assetsWelcomeAppstoreBadge)
                              ])
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100)),
                      child: Image.asset(
                        Assets.assetsWelcomeWebHeader,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      Assets.assetsWelcomeWebBg,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      Assets.assetsWelcomeZigZagLayer,
                      fit: BoxFit.fill,
                      opacity: const AlwaysStoppedAnimation(0.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: appWidgetGap,
                        left: appWidgetGap,
                        right: appWidgetGap / 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: appWidgetGap, right: appWidgetGap / 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kPowerFulFeatures,
                                      style: secMed48.copyWith(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w800)),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: kAchieve,
                                        style: secMed48.copyWith(
                                            color: Colors.white,
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w800)),
                                    TextSpan(
                                        text: kFaster,
                                        style: secMed48.copyWith(
                                            color: Colors.orange[800],
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w800)),
                                  ])),
                                  Text(kTrade,
                                      style: secMed48.copyWith(
                                          color: Colors.orange[800],
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w800)),
                                  const SizedBox(height: appWidgetGap),
                                  appDescriptionText(context, kGetInstant,
                                      kPostYourRequirementAnd),
                                  const SizedBox(height: appPadding * 2),
                                  appDescriptionText(context,
                                      kNegotiateWithEase, kChatWithCustomers),
                                  const SizedBox(height: appPadding * 2),
                                  appDescriptionText(
                                      context, kGetMarketUpdate, kStayUpdated),
                                ]),
                          ),
                          Expanded(
                              child:
                                  Image.asset(Assets.assetsWelcomeAppScreens))
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              padding: const EdgeInsets.only(
                  top: appWidgetGap * 2,
                  left: appWidgetGap,
                  right: appWidgetGap,
                  bottom: appWidgetGap * 2),
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: appWidgetGap / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(kHowToUse,
                          style: secMed48.copyWith(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800)),
                      Text(kMetalTradeApp,
                          style: secMed48.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          kWeAreEndToEnd,
                          style: secMed18.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontFamily: "Nunito"),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: appWorkingDemo(context))
              ]),
            ),
            Image.asset(
              Assets.assetsWelcomeWebImg2,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: appWidgetGap * 2),
            const NeedMoreInfoWidget(),
            const SizedBox(height: appWidgetGap * 2),
            const WebFooter()
          ],
        ),
      ),
    );
  }

  Widget appBarTextButton(
      BuildContext context, String text, Function onPressed) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text,
            style: secMed14.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                fontFamily: "Nunito")));
  }

  Widget appDescriptionText(
      BuildContext context, String title, String subtitle) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: secMed24.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Nunito")),
          Text(subtitle,
              style:
                  secMed20.copyWith(color: Colors.white, fontFamily: "Nunito"))
        ],
      ),
    );
  }

  Widget appWorkingDemo(BuildContext context) {
    return Column(
      children: [
        appDemoTextfield(context, kCreateYourRfq),
        const SizedBox(height: appPadding),
        appDemoTextfield(context, kSubmitQuote),
        const SizedBox(height: appPadding),
        appDemoTextfield(context, kAcceptAQuote),
        const SizedBox(height: appPadding),
        appDemoTextfield(context, kMyRfqAndQuotes)
      ],
    );
  }

  Widget appDemoTextfield(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width / 2,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style: secMed20.copyWith(
                fontFamily: "Nunito", fontWeight: FontWeight.w700)),
        const Icon(Icons.arrow_drop_down)
      ]),
    );
  }
}
