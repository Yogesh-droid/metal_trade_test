import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/quote_filter_cubit/quote_filter_cubit.dart';
import 'package:metaltrade/features/my_home/ui/widgets/quote_filters.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import '../../../../core/routes/routes.dart';
import '../../../chat/ui/controllers/chat_bloc/chat_bloc.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../../profile/ui/widgets/kyc_dialog.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.profileEntity.company != null) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const QuoteFilters(),
                  BlocBuilder<MyQuoteBloc, MyQuoteState>(
                      builder: (context, state) {
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
                                  onBorderedBtnTapped: () {
                                    context.read<ChatBloc>().add(
                                        GetPreviousChatEvent(
                                            chatType: ChatType.enquiry.name,
                                            enquiryId: e.enquiry!.id!,
                                            page: 0));
                                    context.pushNamed(chatPageName,
                                        queryParameters: {
                                          'room': e.uuid ?? ''
                                        });
                                  },
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
          } else {
            return KycDialog(
              profileEntity: ProfileEntity(),
            );
          }
        } else if (state is ProfileFailed) {
          return const Center(
              child: Text("Something went wrong !! \n Profile not found",
                  textAlign: TextAlign.center));
        }
        return const SizedBox(
          child: Center(child: LoadingDots()),
        );
      },
    );
  }
}
