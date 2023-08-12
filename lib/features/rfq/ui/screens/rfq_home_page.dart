import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/screens/buyer_rfq_page.dart';
import 'package:metaltrade/features/rfq/ui/screens/seller_rfq_page.dart';
import 'package:metaltrade/features/rfq/ui/widgets/search_widget_without_suggestions.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../widgets/home_page_appbar_bottom.dart';

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
  final FocusNode searchFocusNode = FocusNode();
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();
    profileBloc.add(GetUserProfileEvent());
    rfqBuyerEnquiryBloc = context.read<RfqBuyerEnquiryBloc>();
    rfqSellerEnquiryBloc = context.read<RfqSellerEnquiryBloc>();
    _tabController = TabController(length: 2, vsync: this);

    rfqBuyerEnquiryBloc
        .add(GetRfqBuyerPageEnquiryEvent(page: 0, intent: UserIntent.Buy));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
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
      height: 110,
      title: SearchWidgetWithoutSuggestions(
          focusNode: searchFocusNode,
          textEditingController: searchController,
          onSearchTapped: (value) {
            if (_tabController.index == 0) {
              rfqBuyerEnquiryBloc.add(GetRfqBuyerPageEnquiryEvent(
                  page: 0, intent: UserIntent.Buy, text: value));
            } else {
              rfqSellerEnquiryBloc.add(GetRfqSellerEnquiryEvent(
                  page: 0, intent: UserIntent.Sell, text: value));
            }
          }),
      elevation: 5,
      bottomWidget: HomePageAppbarBottom(
          tabList: const [
            Tab(text: kBuyer),
            Tab(text: kSeller),
          ],
          tabController: _tabController,
          onTap: (value) {
            searchController.clear();
            if (value == 0) {
              if (rfqBuyerEnquiryBloc.buyerRfqList.isEmpty) {
                rfqBuyerEnquiryBloc.add(GetRfqBuyerPageEnquiryEvent(
                    page: rfqBuyerEnquiryBloc.buyerRfqListPage,
                    intent: UserIntent.Buy,
                    text: searchController.text));
              }
            } else {
              if (rfqSellerEnquiryBloc.sellerRfqList.isEmpty) {
                rfqSellerEnquiryBloc.add(GetRfqSellerEnquiryEvent(
                    page: rfqSellerEnquiryBloc.sellerRfqListPage,
                    intent: UserIntent.Sell,
                    text: searchController.text));
              }
            }
          }),
    );
  }
}
