import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/add_member_cubit/add_member_cubit.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/add_member_widget.dart';
import 'package:metaltrade/features/profile/ui/widgets/change_language_page.dart';
import 'package:metaltrade/features/profile/ui/widgets/option_tile.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';

import '../../../auth/ui/widgets/app_web_pages.dart';
import '../widgets/confirmation_sheet.dart';
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
    context.read<AddMemberCubit>().getAllEmployees();
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
                const SizedBox(height: appWidgetGap * 2),
                const ProfileTile(),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kMyOrders.tr(),
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
                      title: kAddMember.tr(),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AddMemberWidget(
                                  textEditingController: phoneNoFieldController,
                                  onSendClick: (phoneNo) {
                                    context
                                        .read<AddMemberCubit>()
                                        .addMember(phoneNo);
                                  });
                            });
                      }),
                ),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kChangeLanguage.tr(),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeLangauge()));
                    }),
                const SizedBox(height: appPadding),
                OptionTile(title: kRateUs.tr()),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kTermsOfUse.tr(),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppWebPages(
                                  url: "https://metaltrade.io/terms.html",
                                  title: kTermsOfUse.tr())));
                    }),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kPrivacyPolicy.tr(),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppWebPages(
                                  url: "https://metaltrade.io/privacy.html",
                                  title: kPrivacyPolicy.tr())));
                    }),
                const SizedBox(height: appPadding),
                OptionTile(
                    title: kDeleteAccount.tr(),
                    onTap: () {
                      showModalBottomSheet(
                          isDismissible: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) {
                            return ConfirmationSheet(
                              onConfirmTapped: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(LogoutUserProfileEvent());
                                context.read<MyQuoteBloc>().myQuoteList.clear();
                                context.read<MyRfqBloc>().myRfqList.clear();
                                context
                                    .read<RfqBuyerEnquiryBloc>()
                                    .buyerRfqList
                                    .clear();
                                context.read<ProfileBloc>().add(DeleteAccount(
                                    context
                                            .read<ProfileBloc>()
                                            .profileEntity!
                                            .mobileNumber ??
                                        ''));
                                context.pop();
                                context.go(loginPageRoute);
                              },
                              title: kDoYouWantToDelete.tr(),
                              filledBtnText: kDeleteAccount.tr(),
                              outlinedBtnText: kCancel.tr(),
                              explanation: kByDeletingAcc.tr(),
                              height: MediaQuery.of(context).size.height / 3,
                            );
                          });
                    }),
                const SizedBox(height: appPadding),
                GetStartedBtn(
                    title: kLogout.tr(),
                    onPressed: () {
                      context.read<ProfileBloc>().add(LogoutUserProfileEvent());
                      context.read<MyQuoteBloc>().myQuoteList.clear();
                      context.read<MyRfqBloc>().myRfqList.clear();
                      context.read<RfqBuyerEnquiryBloc>().buyerRfqList.clear();
                      context
                          .read<RfqSellerEnquiryBloc>()
                          .sellerRfqList
                          .clear();
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
