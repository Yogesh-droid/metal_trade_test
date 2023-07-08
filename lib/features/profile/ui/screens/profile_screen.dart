import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
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
      appBar: const ContextMenuAppBar(title: kMyProfile),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileTile(),
                const SizedBox(height: appPadding),
                const OptionTile(title: kMyEnquiry, leading: Icon(Icons.note)),
                const SizedBox(height: appPadding),
                const OptionTile(title: kMyEnquiry, leading: Icon(Icons.note)),
                const SizedBox(height: appPadding),
                const OptionTile(title: kMyEnquiry, leading: Icon(Icons.note)),
                const SizedBox(height: appPadding),
                const OptionTile(title: kMyEnquiry, leading: Icon(Icons.note)),
                const SizedBox(height: appPadding),
                const OptionTile(title: kMyEnquiry, leading: Icon(Icons.note)),
                const SizedBox(height: appWidgetGap),
                GetStartedBtn(
                    title: kLogout,
                    onPressed: () {
                      context.read<ProfileBloc>().add(LogoutUserProfileEvent());
                    },
                    height: 48,
                    width: MediaQuery.of(context).size.width / 1.5)
              ]),
        ),
      ),
    );
  }
}
