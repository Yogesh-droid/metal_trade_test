import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_rfq_screen.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
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
  final SearchController searchController = SearchController();

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    myQuoteBloc = context.read<MyQuoteBloc>();
    _tabController = TabController(length: 3, vsync: this);
    myRfqBloc.add(GetMyRfqList(page: 0, isLoadMore: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      appBar: MainAppBar(
        //height: 100,
        //title: const Text(kHome),
        elevation: 5,
        bottomWidget: HomePageAppbarBottom(
            tabList: const [
              Tab(text: kCreateEnquiry),
              Tab(text: kMyENquiries),
              Tab(text: kMyQuotes),
            ],
            tabController: _tabController,
            isScrollable: true,
            onTap: (value) {
              if (value == 1) {
                if (myRfqBloc.myRfqList.isEmpty && !myRfqBloc.isMyRfqListEnd) {
                  myRfqBloc.add(GetMyRfqList(
                      page:
                          0, // we are hitting page 0 to make load same page data with filters
                      status: [EnquiryStatus.Active.name],
                      isLoadMore: false));
                }
              } else if (value == 2) {
                if (myQuoteBloc.myQuoteList.isEmpty &&
                    !myQuoteBloc.isMyQuoteListEnd) {
                  myQuoteBloc.add(GetQuoteList(
                      page: myQuoteBloc.myQuoteListPage,
                      status: const [],
                      isLoadMore: false));
                }
              }
            }),
      ),
      body: Column(
        children: [
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            BlocListener<CreateEnquiryBloc, CreateEnquiryState>(
              listener: (context, state) {
                if (state is PostEnquirySuccessful) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Enquiry created Successfully")));
                  context
                      .read<MyRfqBloc>()
                      .add(GetMyRfqList(isLoadMore: false, page: 0));
                  _tabController.animateTo(1);
                } else if (state is PostEnquiryFailed) {
                  print(state.exception.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.exception.toString())));
                }
              },
              child: const CreateEnquiryScreen(),
            ),
            const MyRfqScreen(),
            const MyQuoteScreen()
          ]))
        ],
      ),
    );
  }
}
