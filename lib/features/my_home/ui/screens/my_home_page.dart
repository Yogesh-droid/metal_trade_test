import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_rfq_screen.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
import '../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../../../rfq/ui/widgets/home_page_appbar_bottom.dart';
import '../controllers/my_rfq_bloc/my_rfq_bloc.dart';

// ignore: constant_identifier_names
enum EnquiryStatus { Inreview, Active, Complete, Expired, Closed }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MyRfqBloc myRfqBloc;
  late MyQuoteBloc myQuoteBloc;
  List<String> statusList = [];

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    statusList.add(EnquiryStatus.Active.name);
    myQuoteBloc = context.read<MyQuoteBloc>();
    _tabController = TabController(length: 2, vsync: this);
    myRfqBloc.add(GetMyRfqList(
        page: 0, intent: UserIntent.Buy, status: [EnquiryStatus.Active.name]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MainAppBar(
        height: 100,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person))
        ],
        title: const Text(kMyEnquiry),
        elevation: 5,
        bottomWidget: HomePageAppbarBottom(
            tabList: const [
              Tab(text: kBuyer),
              Tab(text: kSeller),
            ],
            tabController: _tabController,
            onTap: (value) {
              if (value == 0) {
                if (myRfqBloc.myRfqList.isEmpty && !myRfqBloc.isMyRfqListEnd) {
                  myRfqBloc.add(GetMyRfqList(
                      page: myRfqBloc.myRfqListPage,
                      intent: UserIntent.Buy,
                      status: [EnquiryStatus.Active.name]));
                }
              } else {
                if (myQuoteBloc.myQuoteList.isEmpty &&
                    !myQuoteBloc.isMyQuoteListEnd) {
                  myQuoteBloc.add(GetQuoteList(
                      page: myQuoteBloc.myQuoteListPage,
                      intent: UserIntent.Sell,
                      status: [EnquiryStatus.Active.name]));
                }
              }
            }),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.065,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: EnquiryStatus.values
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilterChip(
                            disabledColor:
                                Theme.of(context).colorScheme.tertiary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(e.name),
                            selected: statusList.contains(e.name),
                            onSelected: (value) {
                              value
                                  ? statusList.add(e.name)
                                  : statusList.remove(e.name);
                              setState(() {});
                              _tabController.index == 0
                                  ? myRfqBloc.add(GetMyRfqList(
                                      intent: UserIntent.Buy,
                                      status: statusList,
                                      page: myRfqBloc.myRfqListPage))
                                  : myQuoteBloc.add(GetQuoteList(
                                      intent: UserIntent.Sell,
                                      status: statusList,
                                      page: myQuoteBloc.myQuoteListPage));
                            }),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: const [MyRfqScreen(), MyQuoteScreen()]))
        ],
      ),
    );
  }
}
