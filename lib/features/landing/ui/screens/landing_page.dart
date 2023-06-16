import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            const SizedBox(height: 200),
            SizedBox(
                key: const ValueKey("WelcomeSizedBox2"),
                height: 400,
                width: 300,
                child: WelcomePageView(
                    key: const ValueKey("WelcomePageView"), pages: introPages)),
            const Spacer(),
            GetStartedBtn(
              title: kGetStarted,
              onPressed: () async {
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
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
