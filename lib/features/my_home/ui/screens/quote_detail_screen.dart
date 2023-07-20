import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/my_home/ui/widgets/quote_detail_card.dart';

import '../controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';

class QuoteDetailScreen extends StatefulWidget {
  const QuoteDetailScreen({super.key, required this.content});
  final Content content;

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  ScrollController scrollController = ScrollController();
  late QuoteDetailListBloc quoteDetailListBloc;

  @override
  void initState() {
    quoteDetailListBloc = context.read<QuoteDetailListBloc>();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !quoteDetailListBloc.isQuoteListEnd) {
        quoteDetailListBloc.add(GetQuoteDetailList(
            page: quoteDetailListBloc.quoteListPage + 1,
            enquiryId: widget.content.id!,
            isLoadMore: true));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.outlineVariant,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            BlocBuilder<QuoteDetailListBloc, QuoteDetailListState>(
              builder: (context, state) {
                if (state is QuoteDetailListInitial) {
                  return const Center(child: LoadingDots());
                }
                if (state is QuoteDetailListSuccess ||
                    state is QuoteDetailListLoadMore) {
                  return quoteDetailListBloc.contentList.isEmpty
                      ? noItemCard()
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              Container(height: appPadding),
                          shrinkWrap: true,
                          itemCount: quoteDetailListBloc.contentList.length,
                          itemBuilder: (context, index) => QuoteDetailCard(
                                item: quoteDetailListBloc
                                    .contentList[index].item!,
                                uuid: widget.content.uuid!,
                                lastDateModified:
                                    widget.content.lastModifiedDate,
                                outlinedBtnText: kChat,
                                onOutlinedBtnTapped: () {},
                                filledBtnText: kAccept,
                                onFilledBtnTapped: () {},
                              ));
                }
                if (state is QuoteDetailListFailed) {
                  return Center(child: Text(state.exception.toString()));
                }
                return const Center(child: Text("Some Err"));
              },
            ),
            SizedBox(
              height: 100,
              child: BlocBuilder<QuoteDetailListBloc, QuoteDetailListState>(
                builder: (context, state) {
                  if (state is QuoteDetailListLoadMore) {
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

  Widget noItemCard() {
    return Card(
      margin: const EdgeInsets.only(top: 70),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height - 400,
          width: MediaQuery.of(context).size.width,
          child: const Text("No Quote Yet", textAlign: TextAlign.center)),
    );
  }
}
