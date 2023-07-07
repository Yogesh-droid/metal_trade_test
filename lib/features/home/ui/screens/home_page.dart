import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/screens/buyer_enquiry_page.dart';
import 'package:metaltrade/features/home/ui/screens/seller_enquiry_page.dart';
import 'package:metaltrade/features/home/ui/widgets/home_page_appbar_bottom.dart';
import 'package:metaltrade/features/home/ui/widgets/search_bar_widget.dart';

import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HomePageBuyerEnquiryBloc homePageBuyerEnquiryBloc;
  late HomePageSellerEnquiryBloc homePageSellerEnquiryBloc;
  final SearchController searchController = SearchController();
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();
    profileBloc.add(GetUserProfileEvent());
    _tabController = TabController(length: 2, vsync: this);

    profileBloc.stream.listen((state) {
      if (state is ProfileSuccessState && state.profileEntity.company != null) {
        homePageBuyerEnquiryBloc = context.read<HomePageBuyerEnquiryBloc>();
        homePageSellerEnquiryBloc = context.read<HomePageSellerEnquiryBloc>();
        homePageBuyerEnquiryBloc
            .add(GetHomeBuyerPageEnquiryEvent(page: 0, intent: UserIntent.Buy));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MainAppBar(
          height: 100,
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          //   IconButton(
          //       onPressed: () {
          //         context.pushNamed(profilePageName);
          //       },
          //       icon: const Icon(Icons.person))
          // ],
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
                  if (homePageBuyerEnquiryBloc.buyerEnquiryList.isEmpty &&
                      !homePageBuyerEnquiryBloc.isBuyerListEnd) {
                    homePageBuyerEnquiryBloc.add(GetHomeBuyerPageEnquiryEvent(
                        page: homePageBuyerEnquiryBloc.buyerListPage,
                        intent: UserIntent.Buy));
                  }
                } else {
                  if (homePageSellerEnquiryBloc.sellerEnquiryList.isEmpty &&
                      !homePageSellerEnquiryBloc.isSellerListEnd) {
                    homePageSellerEnquiryBloc.add(GetHomePageSellerEnquiryEvent(
                        page: homePageSellerEnquiryBloc.sellerListPage,
                        intent: UserIntent.Sell));
                  }
                }
              }),
        ),
        body: Column(
          children: [
            Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: const [BuyerEnquiryPage(), SellerEnquiryPage()]))
          ],
        ));
  }
}
