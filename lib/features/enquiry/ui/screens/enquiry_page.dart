import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/screens/my_enquiry_buy_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
import '../../../home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import '../../../home/ui/widgets/home_page_appbar_bottom.dart';

class EnquiryPage extends StatefulWidget {
  const EnquiryPage({super.key});

  @override
  State<EnquiryPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MyEnquiryBloc myEnquiryBloc;
  late MyEnquirySellBloc myEnquirySellBloc;

  @override
  void initState() {
    myEnquiryBloc = context.read<MyEnquiryBloc>();
    myEnquirySellBloc = context.read<MyEnquirySellBloc>();
    _tabController = TabController(length: 2, vsync: this);
    myEnquiryBloc
        .add(GetMyEnquiryList(page: 0, intent: UserIntent.Buy, status: []));
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
        title: const Text(kMyEnquiry),
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
                if (myEnquiryBloc.myEnquiryList.isEmpty &&
                    !myEnquiryBloc.isMyEnquiryListEnd) {
                  myEnquiryBloc.add(GetMyEnquiryList(
                      page: myEnquiryBloc.myEnquiryListPage,
                      intent: UserIntent.Buy,
                      status: []));
                }
              } else {
                if (myEnquirySellBloc.myEnquirySellList.isEmpty &&
                    !myEnquirySellBloc.isMyEnquirySellListEnd) {
                  myEnquirySellBloc.add(GetMyEnquirySellList(
                      page: myEnquirySellBloc.myEnquirySellListPage,
                      intent: UserIntent.Sell,
                      status: []));
                }
              }
            }),
      ),
      body: Column(
        children: [
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: const [MyEnquiryBuyScreen(), MyEnquiryBuyScreen()]))
        ],
      ),
    );
  }
}
