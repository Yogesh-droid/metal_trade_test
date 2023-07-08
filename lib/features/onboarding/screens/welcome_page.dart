//**
// This is where we show App logo having wavy shimmer
// */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_theme.dart';
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
      body: Center(
        child: Image.asset(
          Assets.assetsWelcomeAppLogo,
          fit: BoxFit.contain,
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  Future<void> appStartUp(BuildContext context) async {
    await LocalStorage.instance.getToken().then((value) {
      if (value.isEmpty) {
        context.go(landingPageRoute);
      } else {
        debugPrint("token is =>=>=>=>  $value");
        context.go(dashBoardRoute);
        //context.read<ProfileBloc>().add(GetProfileEvent());
      }
    });

    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    platformDispatcher.onPlatformBrightnessChanged = () {
      appTheme.getAppTheme(platformDispatcher.platformBrightness);
    };
  }
}
