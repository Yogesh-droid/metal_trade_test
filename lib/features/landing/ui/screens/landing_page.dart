import 'package:flutter/material.dart';
import 'package:metaltrade/features/landing/ui/screens/mobile_landing_page.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/strings.dart';
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
    return const MobileLandingPage();
  }
}
