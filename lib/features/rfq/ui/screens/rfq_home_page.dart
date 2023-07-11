import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/screens/buyer_rfq_page.dart';
import 'package:metaltrade/features/rfq/ui/screens/seller_rfq_page.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../widgets/home_page_appbar_bottom.dart';
import '../widgets/search_bar_widget.dart';

class RfqHomePage extends StatefulWidget {
  const RfqHomePage({super.key});

  @override
  State<RfqHomePage> createState() => _RfqHomePageState();
}

class _RfqHomePageState extends State<RfqHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RfqBuyerEnquiryBloc rfqBuyerEnquiryBloc;
  late RfqSellerEnquiryBloc rfqSellerEnquiryBloc;
  final SearchController searchController = SearchController();
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();
    profileBloc.add(GetUserProfileEvent());
    _tabController = TabController(length: 2, vsync: this);

    profileBloc.stream.listen((state) {
      if (state is ProfileSuccessState && state.profileEntity.company != null) {
        rfqBuyerEnquiryBloc = context.read<RfqBuyerEnquiryBloc>();
        rfqSellerEnquiryBloc = context.read<RfqSellerEnquiryBloc>();
        rfqBuyerEnquiryBloc
            .add(GetRfqBuyerPageEnquiryEvent(page: 0, intent: UserIntent.Buy));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        appBar: mainAppBar(context),
        body: Column(
          children: [
            Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: const [BuyerRfqPage(), SellerRfqPage()]))
          ],
        ));
  }

  mainAppBar(BuildContext context) {
    return MainAppBar(
      height: 100,
      title: SearchBarWidget(searchController: searchController),
      elevation: 5,
      bottomWidget: HomePageAppbarBottom(
          tabList: const [
            Tab(text: kBuyer),
            Tab(text: kSeller),
          ],
          tabController: _tabController,
          onTap: (value) {
            if (value == 0) {
              if (rfqBuyerEnquiryBloc.buyerRfqList.isEmpty &&
                  !rfqBuyerEnquiryBloc.isBuyerRfqListEnd) {
                rfqBuyerEnquiryBloc.add(GetRfqBuyerPageEnquiryEvent(
                    page: rfqBuyerEnquiryBloc.buyerRfqListPage,
                    intent: UserIntent.Buy));
              }
            } else {
              if (rfqSellerEnquiryBloc.sellerRfqList.isEmpty &&
                  !rfqSellerEnquiryBloc.isSellerRfqListEnd) {
                rfqSellerEnquiryBloc.add(GetRfqSellerEnquiryEvent(
                    page: rfqSellerEnquiryBloc.sellerRfqListPage,
                    intent: UserIntent.Sell));
              }
            }
          }),
    );
  }
}
