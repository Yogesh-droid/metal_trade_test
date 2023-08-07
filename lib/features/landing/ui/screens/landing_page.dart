import 'package:flutter/material.dart';
import 'package:metaltrade/features/landing/ui/screens/mobile_landing_page.dart';

import '../../../../core/constants/strings.dart';
import '../widgets/intro_widget.dart';

List<Widget> introPages = [
  const IntroWidget(
      title: kMeetNewLeads,
      subtitle: kConnectWithCountless),
  const IntroWidget(
      title: kGetInstantQuote,
      subtitle: kPostRequirements),
  const IntroWidget(
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
