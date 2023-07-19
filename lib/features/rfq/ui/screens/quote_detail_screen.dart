import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/widgets/quote_detail_card.dart';

import '../controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';

class QuoteDetailScreen extends StatefulWidget {
  const QuoteDetailScreen({super.key, required this.content});
  final Content content;

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  late ScrollController scrollController;
  late QuoteDetailListBloc quoteDetailListBloc;
  bool isLoadMore = false;

  @override
  void initState() {
    scrollController = ScrollController();
    quoteDetailListBloc = context.read<QuoteDetailListBloc>();
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !quoteDetailListBloc.isQuoteListEnd) {
      setState(() {
        isLoadMore = true;
      });
      quoteDetailListBloc.add(GetQuoteDetailList(
          page: quoteDetailListBloc.quoteListPage + 1,
          enquiryId: widget.content.id!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteDetailListBloc, QuoteDetailListState>(
      builder: (context, state) {
        if (state is QuoteDetailListInitial) {
          return const Center(child: LoadingDots());
        }
        if (state is QuoteDetailListSuccess) {
          return ListView.separated(
              controller: scrollController,
              separatorBuilder: (context, index) => Container(
                  height: appPadding,
                  color: Theme.of(context).colorScheme.secondary),
              shrinkWrap: true,
              itemCount: state.contentList.length,
              itemBuilder: (context, index) => QuoteDetailCard(
                    item: state.contentList[index].item!,
                    uuid: widget.content.uuid!,
                    lastDateModified: widget.content.lastModifiedDate,
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
    );
  }
}
