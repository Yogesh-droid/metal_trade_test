//**
// This is where we show App logo having wavy shimmer
// */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_theme.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/hive/local_storage.dart';
import '../../../core/routes/routes.dart';
import '../../landing/ui/screens/web_landing_page.dart';

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
    return (kIsWeb)
        ? const WebLandingPage()
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            body: Center(
              child: Image.asset(
                Assets.assetsWelcomeWelcomPage,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          );
  }

  Future<void> appStartUp(BuildContext context) async {
    if (!kIsWeb) {
      String token = await LocalStorage.instance.getToken();
      Future.delayed(const Duration(seconds: 3), () async {
        if (token.isEmpty) {
          context.go(landingPageRoute);
        } else {
          debugPrint("token is =>=>=>=>  $token");
          context.go(dashBoardRoute);
        }
      });
    }

    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    platformDispatcher.onPlatformBrightnessChanged = () {
      appTheme.getAppTheme(platformDispatcher.platformBrightness);
    };
  }
}
