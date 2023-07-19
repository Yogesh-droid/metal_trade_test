import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';

import '../../../../core/routes/routes.dart';
import '../../../rfq/ui/widgets/home_page_card.dart';

class MyRfqScreen extends StatefulWidget {
  const MyRfqScreen({super.key});

  @override
  State<MyRfqScreen> createState() => _MyRfqScreenState();
}

class _MyRfqScreenState extends State<MyRfqScreen> {
  ScrollController scrollController = ScrollController();
  late MyRfqBloc myRfqBloc;
  late FilterStatusCubit filterStatusCubit;

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    filterStatusCubit = context.read<FilterStatusCubit>();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myRfqBloc.isMyRfqListEnd) {
        myRfqBloc.add(GetMyRfqList(
            page: myRfqBloc.myRfqListPage + 1,
            status: filterStatusCubit.statusList,
            isLoadMore: true));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const FilterChipList(),
            BlocBuilder<MyRfqBloc, MyRfqState>(builder: (context, state) {
              if (state is MyRfqInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MyRfqFetchedState || state is MyRfqLoadMore) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: myRfqBloc.myRfqList
                      .map((e) => HomePageCard(
                          content: e,
                          itemList: e.item,
                          country: e.enquiryCompany!.country!.name,
                          uuid: e.uuid,
                          borderedBtnTitle:
                              e.status == "Expired" ? kReopen : kCloseRfq,
                          filledBtnTitle: e.status != "Inreview"
                              ? e.quoteCount! > 0
                                  ? "$kView ${e.quoteCount} $kQuote"
                                  : null
                              : null,
                          onBorderedBtnTapped: () {},
                          onFilledBtnTapped: () {},
                          onDetailTapped: () {
                            context.pushNamed(myEnqiryDetailPageName, extra: e);
                          }))
                      .toList(),
                );
              } else {
                return const SizedBox();
              }
            }),
            SizedBox(
              height: 100,
              child: BlocBuilder<MyRfqBloc, MyRfqState>(
                builder: (context, state) {
                  if (state is MyRfqLoadMore) {
                    return const LoadingDots();
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
