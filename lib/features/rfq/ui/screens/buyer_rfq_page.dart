import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;
import 'package:metaltrade/features/quotes/data/models/quote_res_model.dart';

import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../widgets/home_page_card.dart';

class BuyerRfqPage extends StatefulWidget {
  const BuyerRfqPage({super.key});

  @override
  State<BuyerRfqPage> createState() => _BuyerRfqPageState();
}

class _BuyerRfqPageState extends State<BuyerRfqPage> {
  late ScrollController scrollController;
  late RfqBuyerEnquiryBloc homePageBuyerEnquiryBloc;

  @override
  void initState() {
    scrollController = ScrollController();
    homePageBuyerEnquiryBloc = context.read<RfqBuyerEnquiryBloc>();
    scrollController.addListener(() {
      if (!homePageBuyerEnquiryBloc.isBuyerRfqListEnd) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homePageBuyerEnquiryBloc.add(GetRfqBuyerPageEnquiryEvent(
              page: homePageBuyerEnquiryBloc.buyerRfqListPage,
              intent: UserIntent.Buy));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RfqBuyerEnquiryBloc, RfqBuyerEnquiryState>(
        builder: (context, state) {
      if (state is RfqBuyerEnquiryInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is RfqBuyerEnquiryFetchedState ||
          state is RfqBuyerEnquiryLoadMore) {
        return Column(
          children: [
            Expanded(
              child: homePageBuyerEnquiryBloc.buyerRfqList.isNotEmpty
                  ? ListView(
                      padding: const EdgeInsets.only(top: appFormFieldGap / 2),
                      controller: scrollController,
                      shrinkWrap: true,
                      children: homePageBuyerEnquiryBloc.buyerRfqList
                          .map((e) => HomePageCard(
                                content: e,
                                itemList: e.item,
                                country: e.enquiryCompany!.country!.name,
                                uuid: e.uuid,
                                borderedBtnTitle: kChat.tr(),
                                filledBtnTitle: kSubmitQuote.tr(),
                                isIcon: true,
                                isFilledIcon: false,
                                onBorderedBtnTapped: () {
                                  context.read<ChatBloc>().add(
                                      GetPreviousChatEvent(
                                          chatType: ChatType.enquiry.name,
                                          enquiryId: e.id,
                                          page: 0));
                                  context.pushNamed(chatPageName,
                                      queryParameters: {'room': e.uuid ?? ''},
                                      extra: chat_res.Content(
                                          body: chat_res.Body(
                                            chatMessageType: "Enquiry",
                                            enquiry: Enquiry(
                                              lastModifiedDate:
                                                  DateTime.now().toString(),
                                              id: e.id,
                                              item: e.item,
                                              uuid: e.uuid,
                                            ),
                                          ),
                                          enquiryId: e.id,
                                          lastModifiedDate: DateTime.now(),
                                          status: "Unseen"));
                                },
                                onFilledBtnTapped: () {
                                  context.pushNamed(submitQuotePageName,
                                      extra: e);
                                },
                                onDetailTapped: () {
                                  context.pushNamed(enquiryDetailPageName,
                                      extra: e,
                                      queryParameters: {
                                        'title': kEnquiryDetail.tr(),
                                        'country':
                                            e.enquiryCompany!.country!.name,
                                        'isMyEnquiry': 'yes'
                                      });
                                },
                              ))
                          .toList(),
                    )
                  : const Center(
                      child: Text('No Enquiries found.'),
                    ),
            ),
            if (state is RfqBuyerEnquiryLoadMore)
              Container(
                  color: Theme.of(context).colorScheme.onPrimary,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const LoadingDots()),
          ],
        );
      } else if (state is RfqBuyerEnquiryFailed) {
        return Center(child: Text(state.exception.toString()));
      } else {
        return const Center(child: Text("Some Error"));
      }
    });
  }
}
