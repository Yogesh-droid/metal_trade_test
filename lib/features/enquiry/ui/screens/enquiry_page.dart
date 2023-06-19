import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/my_enquiry_buy_bloc/my_enquiry_buy_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/controllers/my_enquiry_sell_bloc/my_enquiry_sell_bloc.dart';
import 'package:metaltrade/features/enquiry/ui/screens/my_enquiry_buy_screen.dart';
import 'package:metaltrade/features/enquiry/ui/screens/my_enquiry_sell_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
import '../../../home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
import '../../../home/ui/widgets/home_page_appbar_bottom.dart';

// ignore: constant_identifier_names
enum EnquiryStatus { Inreview, Active, Complete, Expired, Closed }

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
  List<String> statusList = [];

  @override
  void initState() {
    myEnquiryBloc = context.read<MyEnquiryBloc>();
    statusList.add(EnquiryStatus.Active.name);
    myEnquirySellBloc = context.read<MyEnquirySellBloc>();
    _tabController = TabController(length: 2, vsync: this);
    myEnquiryBloc.add(GetMyEnquiryList(
        page: 0, intent: UserIntent.Buy, status: [EnquiryStatus.Active.name]));
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
                      status: [EnquiryStatus.Active.name]));
                }
              } else {
                if (myEnquirySellBloc.myEnquirySellList.isEmpty &&
                    !myEnquirySellBloc.isMyEnquirySellListEnd) {
                  myEnquirySellBloc.add(GetMyEnquirySellList(
                      page: myEnquirySellBloc.myEnquirySellListPage,
                      intent: UserIntent.Sell,
                      status: [EnquiryStatus.Active.name]));
                }
              }
            }),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: EnquiryStatus.values
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                            disabledColor: grey8,
                            backgroundColor: grey8,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(e.name),
                            selected: statusList.contains(e.name),
                            selectedColor: blue,
                            checkmarkColor: white,
                            labelStyle: statusList.contains(e.name)
                                ? secMed14.copyWith(color: white)
                                : secMed14,
                            onSelected: (value) {
                              value
                                  ? statusList.add(e.name)
                                  : statusList.remove(e.name);
                              setState(() {});
                              _tabController.index == 0
                                  ? myEnquiryBloc.add(GetMyEnquiryList(
                                      intent: UserIntent.Buy,
                                      status: statusList,
                                      page: myEnquiryBloc.myEnquiryListPage))
                                  : myEnquirySellBloc.add(GetMyEnquirySellList(
                                      intent: UserIntent.Sell,
                                      status: statusList,
                                      page: myEnquirySellBloc
                                          .myEnquirySellListPage));
                            }),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: const [
            MyEnquiryBuyScreen(),
            MyEnquirySellScreen()
          ]))
        ],
      ),
    );
  }
}
