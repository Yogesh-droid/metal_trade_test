//**
// This is where we show App logo having wavy shimmer
// */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_theme.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/hive/local_storage.dart';
import '../../../core/routes/routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late AppTheme appTheme;
  @override
  void initState() {
    appTheme = context.read<AppTheme>();
    appStartUp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.assetsWelcomeWelcomPage,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
              bottom: appWidgetGap,
              child: Text(
                "Asia's Marketplace for Steel",
                style: secMed15.copyWith(
                    fontFamily: 'Nunito', color: Colors.white),
              ))
        ],
      ),
    );
  }

  Future<void> appStartUp(BuildContext context) async {
    String token = await LocalStorage.instance.getToken();
    debugPrint('Token is $token');
    int? noOfTimesAppOpening = await LocalStorage.instance.getIsUserFirstTime();
    await LocalStorage.instance.saveIsUserFirstTime(noOfTimesAppOpening + 1);
    Future.delayed(const Duration(seconds: 2), () async {
      if (token.isEmpty) {
        noOfTimesAppOpening > 0
            ? context.go(loginPageRoute)
            : context.go(landingPageRoute);
      } else {
        context.go(dashBoardRoute);
      }
    });

    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    platformDispatcher.onPlatformBrightnessChanged = () {
      appTheme.getAppTheme(platformDispatcher.platformBrightness);
    };
  }
}
