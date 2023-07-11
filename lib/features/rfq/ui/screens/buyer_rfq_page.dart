import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../widgets/home_page_card.dart';

class BuyerRfqPage extends StatefulWidget {
  const BuyerRfqPage({super.key});

  @override
  State<BuyerRfqPage> createState() => _BuyerRfqPageState();
}

class _BuyerRfqPageState extends State<BuyerRfqPage> {
  late ScrollController scrollController;
  late RfqBuyerEnquiryBloc homePageBuyerEnquiryBloc;
  bool isFetchMore = false;

  @override
  void initState() {
    scrollController = ScrollController();
    homePageBuyerEnquiryBloc = context.read<RfqBuyerEnquiryBloc>();
    scrollController.addListener(() {
      if (!homePageBuyerEnquiryBloc.isBuyerRfqListEnd) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homePageBuyerEnquiryBloc.add(GetRfqBuyerPageEnquiryEvent(
              page: homePageBuyerEnquiryBloc.buyerRfqListPage,
              intent: UserIntent.Buy));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileSuccessState) {
          if (profileState.profileEntity.company != null) {
            return BlocBuilder<RfqBuyerEnquiryBloc, RfqBuyerEnquiryState>(
                builder: (context, state) {
              if (state is RfqBuyerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RfqBuyerEnquiryFetchedState ||
                  state is RfqBuyerEnquiryLoadMore) {
                return Stack(
                  children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: homePageBuyerEnquiryBloc.buyerRfqList
                          .map((e) => HomePageCard(
                                content: e,
                                itemList: e.item,
                                country: e.enquiryCompany!.country!.name,
                                uuid: e.uuid,
                                borderedBtnTitle: kChat,
                                filledBtnTitle: "+ $kSubmitQuote",
                                onBorderedBtnTapped: () {},
                                onFilledBtnTapped: () {
                                  context.pushNamed(submitQuotePageName,
                                      extra: e);
                                },
                              ))
                          .toList(),
                    ),
                    if (state is RfqBuyerEnquiryLoadMore)
                      Positioned(
                          bottom: 0,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: const LoadingDots())),
                  ],
                );
              } else if (state is RfqBuyerEnquiryFailed) {
                return Center(child: Text(state.exception.toString()));
              } else {
                return const Center(child: Text("Some Error"));
              }
            });
          } else {
            return const KycDialog();
          }
        }
        return const SizedBox(
          child: Center(child: LoadingDots()),
        );
      },
    );
  }
}
