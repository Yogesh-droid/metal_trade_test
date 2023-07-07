import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/widgets/home_page_card.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';

class BuyerEnquiryPage extends StatefulWidget {
  const BuyerEnquiryPage({super.key});

  @override
  State<BuyerEnquiryPage> createState() => _BuyerEnquiryPageState();
}

class _BuyerEnquiryPageState extends State<BuyerEnquiryPage> {
  late ScrollController scrollController;
  late HomePageBuyerEnquiryBloc homePageBuyerEnquiryBloc;
  bool isFetchMore = false;

  @override
  void initState() {
    scrollController = ScrollController();
    homePageBuyerEnquiryBloc = context.read<HomePageBuyerEnquiryBloc>();
    scrollController.addListener(() {
      if (!homePageBuyerEnquiryBloc.isBuyerListEnd) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homePageBuyerEnquiryBloc.add(GetHomeBuyerPageEnquiryEvent(
              page: homePageBuyerEnquiryBloc.buyerListPage,
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
            return BlocBuilder<HomePageBuyerEnquiryBloc,
                HomePageBuyerEnquiryState>(builder: (context, state) {
              if (state is HomePageBuyerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomePageBuyerEnquiryFetchedState ||
                  state is HomePageBuyerEnquiryLoadMore) {
                return Stack(
                  children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: homePageBuyerEnquiryBloc.buyerEnquiryList
                          .map((e) => HomePageCard(
                                content: e,
                                isSeller: false,
                                companyAddress: e.enquiryCompany!.address,
                                enquiryCommpanyName: e.enquiryCompany!.name,
                                itemList: e.item,
                                ownerName: e.enquiryCompany!.name,
                                datePosted: e.enquiryCompany!.lastModifiedDate,
                                country: e.enquiryCompany!.country!.name,
                                uuid: e.uuid,
                              ))
                          .toList(),
                    ),
                    if (state is HomePageBuyerEnquiryLoadMore)
                      Positioned(
                          bottom: 0,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: const LoadingDots())),
                  ],
                );
              } else if (state is HoemPageBuyerEnquiryFailed) {
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
