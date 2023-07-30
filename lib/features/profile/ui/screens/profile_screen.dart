import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/option_tile.dart';

import '../widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: appWidgetGap),
                const ProfileTile(),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kMyOrders,
                    onTap: () {
                      context.pushNamed(myOrderScreenName);
                    }),
                const SizedBox(height: appPadding),
                const OptionTile(title: kAddMember),
                const SizedBox(height: appPadding),
                const OptionTile(title: kChangeLanguage),
                const SizedBox(height: appPadding),
                const OptionTile(title: kRateUs),
                const SizedBox(height: appPadding),
                const OptionTile(title: kTermsOfUse),
                const SizedBox(height: appPadding),
                const OptionTile(title: kPrivacyPolicy),
                const SizedBox(height: appPadding),
                const OptionTile(title: kDeleteAccount),
                const SizedBox(height: appPadding),
                GetStartedBtn(
                    title: kLogout,
                    onPressed: () {
                      context.read<ProfileBloc>().add(LogoutUserProfileEvent());
                      context.go(loginPageRoute);
                    },
                    height: 48,
                    width: MediaQuery.of(context).size.width / 1.5)
              ]),
        ),
      ),
    );
  }
}
