import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;
import 'package:metaltrade/features/my_home/ui/widgets/quote_detail_card.dart';

import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart' as quote_res;
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
                      : BlocListener<AcceptQuoteBloc, AcceptQuoteState>(
                          listener: (context, state) {
                            if (state is AcceptQuoteSuccessful) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Quote Accepted Successfully')));
                            }
                          },
                          child: ListView.separated(
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
                                    onOutlinedBtnTapped: () {
                                      context.read<ChatBloc>().add(
                                          GetPreviousChatEvent(
                                              chatType: ChatType.quote.name,
                                              quoteId: widget.content.id,
                                              page: 0));
                                      context.pushNamed(chatPageName,
                                          queryParameters: {
                                            'room': widget.content.uuid ?? ''
                                          },
                                          extra: chat_res.Content(
                                              body: chat_res.Body(
                                                chatMessageType: "Quote",
                                                quote: quote_res.Enquiry(
                                                  lastModifiedDate:
                                                      DateTime.now().toString(),
                                                  id: widget.content.id,
                                                  item: widget.content.item,
                                                  uuid: widget.content.uuid,
                                                ),
                                              ),
                                              quoteId: widget.content.id,
                                              enquiryId:
                                                  widget.content.enquiry!.id!,
                                              lastModifiedDate: DateTime.now(),
                                              status: "Unseen"));
                                    },
                                    filledBtnText: kAccept,
                                    onFilledBtnTapped: () {
                                      context.read<AcceptQuoteBloc>().add(
                                          QuoteAcceptEvent(
                                              quoteId: widget.content.id ?? 0));
                                      context.pop();
                                    },
                                  )),
                        );
                }
                if (state is QuoteDetailListFailed) {
                  return Center(child: Text(state.exception.toString()).tr());
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
          child: const Text("No Quote Yet", textAlign: TextAlign.center).tr()),
    );
  }
}
