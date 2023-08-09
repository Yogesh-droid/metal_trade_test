import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;
import 'package:metaltrade/features/my_home/ui/widgets/quote_detail_card.dart';

import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart' as quote_res;
import '../controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import '../controllers/quote_filter_cubit/quote_filter_cubit.dart';

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
                              Fluttertoast.showToast(
                                  msg: "Quote Accepted Successfully");
                              context.read<MyRfqBloc>().add(
                                  GetMyRfqList(isLoadMore: false, page: 0));
                            } else if (state is AcceptQuoteFailed) {
                              Fluttertoast.showToast(
                                  msg: state.exception.toString());
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
                                    uuid: quoteDetailListBloc
                                            .contentList[index].uuid ??
                                        '',
                                    lastDateModified: quoteDetailListBloc
                                        .contentList[index].lastModifiedDate,
                                    outlinedBtnText: quoteDetailListBloc
                                                .contentList[index].status ==
                                            "Active" && widget.content.status == "Active"
                                        ? kChat
                                        : null,
                                    onOutlinedBtnTapped: () {
                                      context.read<ChatBloc>().add(
                                          GetPreviousChatEvent(
                                              chatType: ChatType.quote.name,
                                              quoteId: quoteDetailListBloc
                                                  .contentList[index].id,
                                              enquiryId: widget.content.id,
                                              page: 0));
                                      context.pushNamed(chatPageName,
                                          queryParameters: {
                                            'room': quoteDetailListBloc
                                                    .contentList[index].uuid ??
                                                ''
                                          },
                                          extra: chat_res.Content(
                                              body: chat_res.Body(
                                                chatMessageType: "Quote",
                                                quote: quote_res.Enquiry(
                                                  lastModifiedDate:
                                                      DateTime.now().toString(),
                                                  id: quoteDetailListBloc
                                                      .contentList[index].id,
                                                  item: quoteDetailListBloc
                                                      .contentList[index].item,
                                                  uuid: quoteDetailListBloc
                                                      .contentList[index].uuid,
                                                ),
                                              ),
                                              quoteId: quoteDetailListBloc
                                                  .contentList[index].id,
                                              enquiryId: widget.content.id,
                                              lastModifiedDate: DateTime.now(),
                                              status: "Unseen"));
                                    },
                                    filledBtnText: quoteDetailListBloc
                                                .contentList[index].status ==
                                            "Active" && widget.content.status == "Active"
                                        ? kAccept
                                        : null,
                                    onFilledBtnTapped: () {
                                      context.read<AcceptQuoteBloc>().add(
                                          QuoteAcceptEvent(
                                              quoteId: quoteDetailListBloc
                                                      .contentList[index].id ??
                                                  0,
                                              status: 'Complete'));
                                      context.read<MyQuoteBloc>().add(
                                          GetQuoteList(
                                              isLoadMore: false,
                                              page: 0,
                                              status: context
                                                  .read<QuoteFilterCubit>()
                                                  .statusList));
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
