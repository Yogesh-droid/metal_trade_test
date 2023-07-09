import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_rfq_screen.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
import '../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../../../rfq/ui/widgets/home_page_appbar_bottom.dart';
import '../controllers/my_rfq_bloc/my_rfq_bloc.dart';
import '../widgets/filter_chips_list.dart';

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

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    myQuoteBloc = context.read<MyQuoteBloc>();
    _tabController = TabController(length: 3, vsync: this);
    myRfqBloc.add(GetMyRfqList(page: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
              Tab(text: kCreateEnquiry),
              Tab(text: kMyENquiries),
              Tab(text: kMyQuotes),
            ],
            tabController: _tabController,
            onTap: (value) {
              if (value == 0) {
                if (myRfqBloc.myRfqList.isEmpty && !myRfqBloc.isMyRfqListEnd) {
                  myRfqBloc.add(GetMyRfqList(
                      page:
                          0, // we are hitting page 0 to make load same page data with filters
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
          Expanded(
              child: TabBarView(controller: _tabController, children: const [
            CreateEnquiryScreen(),
            MyRfqScreen(),
            MyQuoteScreen()
          ]))
        ],
      ),
    );
  }
}
