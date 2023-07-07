import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import '../widgets/home_page_card.dart';

class SellerRfqPage extends StatefulWidget {
  const SellerRfqPage({super.key});

  @override
  State<SellerRfqPage> createState() => _SellerRfqPageState();
}

class _SellerRfqPageState extends State<SellerRfqPage> {
  late ScrollController scrollController;
  late RfqSellerEnquiryBloc homePageSellerEnquiryBloc;

  @override
  void initState() {
    scrollController = ScrollController();
    homePageSellerEnquiryBloc = context.read<RfqSellerEnquiryBloc>();
    scrollController.addListener(() {
      if (!homePageSellerEnquiryBloc.isSellerRfqListEnd) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homePageSellerEnquiryBloc.add(GetRfqSellerEnquiryEvent(
              page: homePageSellerEnquiryBloc.sellerRfqListPage,
              intent: UserIntent.Sell));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.profileEntity.company != null) {
            return BlocBuilder<RfqSellerEnquiryBloc, RfqSellerEnquiryState>(
                builder: (context, state) {
              if (state is RfqSellerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RfqSellerEnquiryFetchedState ||
                  state is RfqSellerEnquiryLoadMore) {
                return Stack(
                  children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: homePageSellerEnquiryBloc.sellerRfqList
                          .map((e) => HomePageCard(
                                content: e,
                                isSeller: true,
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
                    if (state is RfqSellerEnquiryLoadMore)
                      Positioned(
                          bottom: 0,
                          child: Container(
                              color: Theme.of(context).colorScheme.onPrimary,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: const LoadingDots())),
                  ],
                );
              } else if (state is RfqSellerEnquiryFailed) {
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
