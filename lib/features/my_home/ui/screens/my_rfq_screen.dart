import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';
import '../../../rfq/ui/widgets/home_page_card.dart';

class MyRfqScreen extends StatefulWidget {
  const MyRfqScreen({super.key});

  @override
  State<MyRfqScreen> createState() => _MyRfqScreenState();
}

class _MyRfqScreenState extends State<MyRfqScreen> {
  late ScrollController scrollController = ScrollController();
  late MyRfqBloc myRfqBloc;
  late FilterStatusCubit filterStatusCubit;
  bool isLoadMore = false;

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    filterStatusCubit = context.read<FilterStatusCubit>();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myRfqBloc.isMyRfqListEnd) {
        setState(() {
          isLoadMore = true;
        });
        myRfqBloc.add(GetMyRfqList(
            page: myRfqBloc.myRfqListPage + 1,
            status: filterStatusCubit.statusList));
        setState(() {
          isLoadMore = false;
        });
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
              } else if (state is MyRfqFetchedState) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: state.contentList
                      .map((e) => HomePageCard(
                            content: e,
                            itemList: e.item,
                            country: e.enquiryCompany!.country!.name,
                            uuid: e.uuid,
                            borderedBtnTitle:
                                e.status == "Expired" ? kReopen : kCloseRfq,
                            filledBtnTitle: e.status != "Inreview"
                                ? e.matchingEnquiries! > 0
                                    ? "$kView ${e.matchingEnquiries} $kQuote"
                                    : null
                                : null,
                            onBorderedBtnTapped: () {},
                            onFilledBtnTapped: () {},
                          ))
                      .toList(),
                );
              } else {
                return const Center(child: Text("Some Error"));
              }
            }),
            if (isLoadMore) const SizedBox(height: 60, child: LoadingDots())
          ],
        ),
      ),
    );
  }
}
