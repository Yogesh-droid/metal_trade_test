import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;
import 'package:metaltrade/features/dashboard/ui/controllers/bottom_bar_controller_cubit.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';
import 'package:metaltrade/features/my_home/ui/widgets/quote_filters.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart';
import '../../../quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import '../widgets/home_page_quote_card.dart';

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
    return Column(
      children: [
        const SizedBox(height: appFormFieldGap / 2),
        const QuoteFilters(),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                BlocListener<AcceptQuoteBloc, AcceptQuoteState>(
                  listener: (context, state) {
                    if (state is QuoteCancelledSuccess) {
                      Fluttertoast.showToast(
                          msg: 'Quote Cancelled Successfully');
                      myQuoteBloc.add(GetQuoteList(
                          isLoadMore: false,
                          page: 0,
                          status: context.read<QuoteFilterCubit>().statusList));
                    } else if (state is QuoteCancelFailed) {
                      Fluttertoast.showToast(msg: state.exception.toString());
                    }
                  },
                  child: BlocBuilder<MyQuoteBloc, MyQuoteState>(
                      builder: (context, state) {
                    if (state is MyQuoteInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MyQuoteFetchedState ||
                        state is MyQuoteLoadMore) {
                      return myQuoteBloc.myQuoteList.isNotEmpty
                          ? ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: myQuoteBloc.myQuoteList
                                  .map((e) => HomePageQuoteCard(
                                        content: e,
                                        itemList: e.item,
                                        country: e.quoteCompany!.country!.name,
                                        uuid: e.uuid,
                                        filledBtnTitle: e.status == 'Inreview'
                                            ? kCancel
                                            : null,
                                        borderedBtnTitle: e.status == 'Inreview'
                                            ? null
                                            : kChat,
                                        onBorderedBtnTapped: () {
                                          context.read<ChatBloc>().add(
                                              GetPreviousChatEvent(
                                                  chatType: ChatType.quote.name,
                                                  quoteId: e.id,
                                                  page: 0));
                                          context.pushNamed(chatPageName,
                                              queryParameters: {
                                                'room': e.uuid ?? ''
                                              },
                                              extra: chat_res.Content(
                                                  body: chat_res.Body(
                                                    chatMessageType: "Quote",
                                                    quote: Enquiry(
                                                      lastModifiedDate:
                                                          DateTime.now()
                                                              .toString(),
                                                      id: e.id,
                                                      item: e.item,
                                                      uuid: e.uuid,
                                                    ),
                                                  ),
                                                  quoteId: e.id,
                                                  enquiryId: e.enquiry!.id!,
                                                  lastModifiedDate:
                                                      DateTime.now(),
                                                  status: "Unseen"));
                                        },
                                        onFilledBtnTapped: () {
                                          context.read<AcceptQuoteBloc>().add(
                                              QuoteCancelEvent(
                                                  quoteId: e.id ?? 0,
                                                  status: 'Closed'));
                                        },
                                      ))
                                  .toList(),
                            )
                          : Center(
                              child: Column(
                              children: [
                                const SizedBox(height: 250),
                                OutlinedButtonWidget(
                                    title: 'Submit Quote',
                                    onPressed: () {
                                      context
                                          .read<BottomNavControllerCubit>()
                                          .changeIndex(1);
                                    })
                              ],
                            ));
                    } else {
                      return const Center(child: Text("Some Error"));
                    }
                  }),
                ),
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
          ),
        ),
      ],
    );
  }
}
