import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_colors.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/controllers/home_page_seller_enquiry_bloc/home_page_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/home/ui/screens/buyer_enquiry_page.dart';
import 'package:metaltrade/features/home/ui/screens/seller_enquiry_page.dart';
import 'package:metaltrade/features/home/ui/widgets/home_page_appbar_bottom.dart';

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

  @override
  void initState() {
    homePageBuyerEnquiryBloc = context.read<HomePageBuyerEnquiryBloc>();
    homePageSellerEnquiryBloc = context.read<HomePageSellerEnquiryBloc>();
    _tabController = TabController(length: 2, vsync: this);
    homePageBuyerEnquiryBloc
        .add(GetHomeBuyerPageEnquiryEvent(page: 0, intent: UserIntent.Buy));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: MainAppBar(
        height: 100,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person))
        ],
        title: const Text(kAppTitle),
        elevation: 5,
        color: white,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(createEnquiryPageName);
        },
        child: const Icon(Icons.note_add_outlined, color: black),
      ),
    );
  }
}
