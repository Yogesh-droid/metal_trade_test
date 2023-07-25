import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/routes/routes.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.assetsWelcomeAppLogoName),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                kFeatures,
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontFamily: "Inter"),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                kHowToUse,
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontFamily: "Inter"),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                kReachUs,
                style: secMed14.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontFamily: "Inter"),
              )),
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
        child: Padding(
          padding: const EdgeInsets.all(appWidgetGap),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: appFormFieldGap * 3),
              SizedBox(
                height: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kTradeOn,
                                  style: secMed48.copyWith(fontFamily: "Inter"),
                                ),
                                Text(kAllProductOfSteel,
                                    style: secMed48.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: "Inter"))
                              ]),
                          Text(
                            kOurOneStop,
                            style: secMed18.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                                fontFamily: "Inter"),
                          )
                        ],
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
                height: 700,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.assetsWelcomeWebBg),
                          fit: BoxFit.cover)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kPowerFulFeatures,
                                  style:
                                      secMed48.copyWith(color: Colors.white)),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: kAchieve,
                                    style:
                                        secMed48.copyWith(color: Colors.white)),
                                TextSpan(
                                    text: kFaster,
                                    style: secMed48.copyWith(
                                        color: Colors.orange[800])),
                              ])),
                              Text(kTrade,
                                  style:
                                      secMed48.copyWith(color: Colors.white)),
                              const SizedBox(height: appWidgetGap),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kGetInstant,
                                      style: secMed24.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  Text(kPostYourRequirementAnd,
                                      style: secMed20.copyWith(
                                          color: Colors.white))
                                ],
                              ),
                              const SizedBox(height: appPadding * 2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kNegotiateWithEase,
                                      style: secMed24.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  Text(kChatWithCustomers,
                                      style: secMed20.copyWith(
                                          color: Colors.white))
                                ],
                              ),
                              const SizedBox(height: appPadding * 2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kGetMarketUpdate,
                                      style: secMed24.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  Text(kStayUpdated,
                                      style: secMed20.copyWith(
                                          color: Colors.white))
                                ],
                              ),
                              const SizedBox(height: appPadding * 2),
                            ]),
                        Image.asset(Assets.assetsWelcomeAppScreens)
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
