import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/landing/ui/widgets/welcome_page_view.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/routes.dart';
import '../widgets/intro_widget.dart';

List<Widget> introPages = [
  const IntroWidget(
      key: ValueKey(Assets.assetsWelcomeWelcome1),
      imagePath: Assets.assetsWelcomeWelcome1,
      title: kMeetNewLeads,
      subtitle: kConnectWithCountless),
  const IntroWidget(
      key: ValueKey(Assets.assetsWelcomeWelcome2),
      imagePath: Assets.assetsWelcomeWelcome2,
      title: kGetInstantQuote,
      subtitle: kPostYourRequirementAnd),
  const IntroWidget(
      key: ValueKey(Assets.assetsWelcomeWelcome3),
      imagePath: Assets.assetsWelcomeWelcome3,
      title: kNegotiateWithEase,
      subtitle: kChatWithExperts),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("LandingScaffold"),
      body: SizedBox(
        key: const ValueKey("WelcomeSizedBox"),
        width: MediaQuery.of(context).size.width,
        child: Column(
          key: const ValueKey("WelcomeColumn"),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Container(
                padding: const EdgeInsets.all(appPadding),
                key: const ValueKey("WelcomeSizedBox2"),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: WelcomePageView(
                    key: const ValueKey("WelcomePageView"), pages: introPages)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(appPadding),
              width: MediaQuery.of(context).size.width,
              child: FilledButtonWidget(
                title: kGetStarted,
                onPressed: () async {
                  //context.go(dashBoardRoute);
                  await LocalStorage.instance.getToken().then((value) {
                    if (value.isEmpty) {
                      context.go(loginPageRoute);
                    } else {
                      debugPrint("token is =>=>=>=>  $value");
                      context.go(dashBoardRoute);
                      //context.read<ProfileBloc>().add(GetProfileEvent());
                    }
                  });
                },
                width: 300,
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
