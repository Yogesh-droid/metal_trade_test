import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/profile/ui/controllers/add_member_cubit/add_member_cubit.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/add_member_widget.dart';
import 'package:metaltrade/features/profile/ui/widgets/option_tile.dart';

import '../widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController phoneNoFieldController = TextEditingController();
  @override
  void initState() {
    if (context.read<AddMemberCubit>().allEmployeeList.isEmpty) {
      context.read<AddMemberCubit>().getAllEmployees();
    }
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
                BlocListener<AddMemberCubit, AddMemberState>(
                  listener: (context, state) {
                    if (state is AddMemberSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Member added successfully")));
                    } else if (state is AddMemberFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.exception.toString())));
                    }
                  },
                  child: OptionTile(
                      title: kAddMember,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AddMemberWidget(
                                  textEditingController: phoneNoFieldController,
                                  onSendClick: () {
                                    context
                                        .read<AddMemberCubit>()
                                        .addMember(phoneNoFieldController.text);
                                  });
                            });
                      }),
                ),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kChangeLanguage,
                    onTap: () {
                      context.setLocale(const Locale('hi', 'IN'));
                    }),
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
