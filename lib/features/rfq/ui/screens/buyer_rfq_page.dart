import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileSuccessState) {
          if (profileState.profileEntity.company != null) {
            return BlocBuilder<RfqBuyerEnquiryBloc, RfqBuyerEnquiryState>(
                builder: (context, state) {
              if (state is RfqBuyerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RfqBuyerEnquiryFetchedState ||
                  state is RfqBuyerEnquiryLoadMore) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        children: homePageBuyerEnquiryBloc.buyerRfqList
                            .map((e) => HomePageCard(
                                  content: e,
                                  itemList: e.item,
                                  country: e.enquiryCompany!.country!.name,
                                  uuid: e.uuid,
                                  borderedBtnTitle: kChat,
                                  filledBtnTitle: "+ $kSubmitQuote",
                                  onBorderedBtnTapped: () {
                                    context.read<ChatBloc>().add(
                                        GetPreviousChatEvent(
                                            chatType: ChatType.enquiry.name,
                                            enquiryId: 6,
                                            page: 0));
                                    context.pushNamed(chatPageName,
                                        queryParameters: {
                                          'room': e.uuid ?? ''
                                        });
                                  },
                                  onFilledBtnTapped: () {
                                    context.pushNamed(submitQuotePageName,
                                        extra: e);
                                  },
                                  onDetailTapped: () {
                                    context.pushNamed(enquiryDetailPageName,
                                        extra: e);
                                  },
                                ))
                            .toList(),
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
          } else {
            return KycDialog(
              profileEntity: ProfileEntity(),
            );
          }
        }
        return const SizedBox(
          child: Center(child: LoadingDots()),
        );
      },
    );
  }
}
