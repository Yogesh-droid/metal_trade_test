import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/hive/local_storage.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/routes.dart';
import '../widgets/get_started_btn.dart';
import '../widgets/welcome_page_view.dart';
import 'landing_page.dart';

class MobileLandingPage extends StatelessWidget {
  const MobileLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
                title: kGetStarted.tr(),
                onPressed: () async {
                  //context.go(dashBoardRoute);
                  await LocalStorage.instance.getToken().then((value) {
                    if (value.isEmpty) {
                      context.go(loginPageRoute);
                    } else {
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
