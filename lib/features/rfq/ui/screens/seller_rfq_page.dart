import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../../quotes/data/models/quote_res_model.dart';
import '../controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import '../controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import '../widgets/home_page_card.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart'
    as chat_res;

class SellerRfqPage extends StatefulWidget {
  const SellerRfqPage({super.key});

  @override
  State<SellerRfqPage> createState() => _SellerRfqPageState();
}

class _SellerRfqPageState extends State<SellerRfqPage> {
  late ScrollController scrollController;
  late RfqSellerEnquiryBloc homePageSellerEnquiryBloc;

  @override
  void initState() {
    scrollController = ScrollController();
    homePageSellerEnquiryBloc = context.read<RfqSellerEnquiryBloc>();
    scrollController.addListener(() {
      if (!homePageSellerEnquiryBloc.isSellerRfqListEnd) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homePageSellerEnquiryBloc.add(GetRfqSellerEnquiryEvent(
              page: homePageSellerEnquiryBloc.sellerRfqListPage,
              intent: UserIntent.Sell));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.profileEntity.company != null) {
            return BlocBuilder<RfqSellerEnquiryBloc, RfqSellerEnquiryState>(
                builder: (context, state) {
              if (state is RfqSellerEnquiryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RfqSellerEnquiryFetchedState ||
                  state is RfqSellerEnquiryLoadMore) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding:
                            const EdgeInsets.only(top: appFormFieldGap / 2),
                        controller: scrollController,
                        shrinkWrap: true,
                        children: homePageSellerEnquiryBloc.sellerRfqList
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
                                          'title': kEnquiryDetail,
                                          'country':
                                              e.enquiryCompany!.country!.name
                                        });
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                    if (state is RfqSellerEnquiryLoadMore)
                      Container(
                          color: Theme.of(context).colorScheme.onPrimary,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: const LoadingDots()),
                  ],
                );
              } else if (state is RfqSellerEnquiryFailed) {
                return Center(child: Text(state.exception.toString()));
              } else {
                return const Center(child: Text("Some Error"));
              }
            });
          } else {
            return KycDialog(profileEntity: ProfileEntity());
          }
        }
        return const SizedBox(
          child: Center(child: LoadingDots()),
        );
      },
    );
  }
}
