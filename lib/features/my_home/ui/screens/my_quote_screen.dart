import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';
import 'package:metaltrade/features/my_home/ui/widgets/quote_filters.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import '../widgets/quote_card.dart';

class MyQuoteScreen extends StatefulWidget {
  const MyQuoteScreen({super.key});

  @override
  State<MyQuoteScreen> createState() => _MyQuoteScreenState();
}

class _MyQuoteScreenState extends State<MyQuoteScreen> {
  late ScrollController scrollController = ScrollController();
  late MyQuoteBloc myQuoteBloc;
  late QuoteFilterCubit quoteFilterCubit;
  bool isLoadMore = false;

  @override
  void initState() {
    myQuoteBloc = context.read<MyQuoteBloc>();
    quoteFilterCubit = context.read<QuoteFilterCubit>();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myQuoteBloc.isMyQuoteListEnd) {
        myQuoteBloc.add(GetQuoteList(
            isLoadMore: true,
            page: myQuoteBloc.myQuoteListPage + 1,
            status: quoteFilterCubit.statusList));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          const QuoteFilters(),
          BlocBuilder<MyQuoteBloc, MyQuoteState>(builder: (context, state) {
            if (state is MyQuoteInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyQuoteFetchedState ||
                state is MyQuoteLoadMore) {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: myQuoteBloc.myQuoteList
                    .map((e) => HomePageQuoteCard(
                          content: e,
                          itemList: e.item,
                          country: e.quoteCompany!.country!.name,
                          uuid: e.uuid,
                          filledBtnTitle:
                              e.status == 'Inreview' ? kCancel : null,
                          borderedBtnTitle: kChat,
                          onBorderedBtnTapped: () {},
                          onFilledBtnTapped: () {},
                        ))
                    .toList(),
              );
            } else {
              return const Center(child: Text("Some Error"));
            }
          }),
          SizedBox(
            height: 100,
            child: BlocBuilder<MyQuoteBloc, MyQuoteState>(
              builder: (context, state) {
                if (state is MyQuoteLoadMore) {
                  return const LoadingDots();
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
