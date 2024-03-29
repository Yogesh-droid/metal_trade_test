import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/home_tab_cubit/home_tab_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_screen.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_rfq_screen.dart';
import '../../../../core/constants/app_widgets/main_app_bar.dart';
import '../../../../core/constants/strings.dart';
import '../../../rfq/ui/widgets/home_page_appbar_bottom.dart';
import '../controllers/enquiry_file_pick_cubit/enquiry_file_pick_cubit.dart';
import '../controllers/filter_status_cubit/filter_status_cubit.dart';
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
    return BlocListener<HomeTabCubit, HomeTabState>(
      listener: (context, state) {
        if (state is HomeTabStateUpdate) {
          _tabController.animateTo(state.index);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
        appBar: MainAppBar(
          elevation: 5,
          bottomWidget: HomePageAppbarBottom(
              tabList: [
                Tab(text: kCreateEnquiry.tr()),
                Tab(text: kMyEnquiry.tr()),
                Tab(text: kMyQuotes.tr()),
              ],
              tabController: _tabController,
              isScrollable: true,
              onTap: (value) {
                if (value == 1) {
                  context.read<EnquiryFilePickCubit>().emitInitialState();
                  if (myRfqBloc.myRfqList.isEmpty &&
                      !myRfqBloc.isMyRfqListEnd) {
                    myRfqBloc.add(GetMyRfqList(
                        page:
                            0, // we are hitting page 0 to make load same page data with filters
                        status: [EnquiryStatus.Active.name],
                        isLoadMore: false));
                  }
                } else if (value == 2) {
                  context.read<EnquiryFilePickCubit>().emitInitialState();
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
                    myRfqBloc.add(GetMyRfqList(
                        page: 0, status: const [], isLoadMore: false));
                    context.read<FilterStatusCubit>().addFilter([]);
                    _tabController.animateTo(1);
                  } else if (state is PostEnquiryFailed) {
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
      ),
    );
  }
}
