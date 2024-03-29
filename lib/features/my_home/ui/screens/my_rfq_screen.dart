import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/home_tab_cubit/home_tab_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';
import '../../../../core/routes/routes.dart';
import '../../../profile/ui/widgets/confirmation_sheet.dart';
import '../../../rfq/ui/widgets/home_page_card.dart';

class MyRfqScreen extends StatefulWidget {
  const MyRfqScreen({super.key});

  @override
  State<MyRfqScreen> createState() => _MyRfqScreenState();
}

class _MyRfqScreenState extends State<MyRfqScreen> {
  ScrollController scrollController = ScrollController();
  late MyRfqBloc myRfqBloc;
  late FilterStatusCubit filterStatusCubit;

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    filterStatusCubit = context.read<FilterStatusCubit>();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myRfqBloc.isMyRfqListEnd) {
        myRfqBloc.add(GetMyRfqList(
            page: myRfqBloc.myRfqListPage + 1,
            status: filterStatusCubit.statusList,
            isLoadMore: true));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: appFormFieldGap / 2),
        const FilterChipList(),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: BlocListener<MyRfqBloc, MyRfqState>(
              listener: (context, state) {
                if (state is UpdateRfqSuccess) {
                  myRfqBloc.add(GetMyRfqList(
                      isLoadMore: false,
                      page: myRfqBloc.myRfqListPage,
                      status: filterStatusCubit.statusList));
                } else if (state is UpdateRfqFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.exception.toString())));
                }
              },
              child: Column(
                children: [
                  BlocBuilder<MyRfqBloc, MyRfqState>(builder: (context, state) {
                    if (state is MyRfqInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MyRfqFetchedState ||
                        state is MyRfqLoadMore ||
                        state is UpdatingRfq ||
                        state is UpdateRfqFailed) {
                      return myRfqBloc.myRfqList.isNotEmpty
                          ? ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: myRfqBloc.myRfqList
                                  .map((e) => HomePageCard(
                                      content: e,
                                      itemList: e.item,
                                      enquiryType: e.enquiryType,
                                      uuid: e.uuid,
                                      isIcon:
                                          e.status == "Complete" ? true : false,
                                      isFilledIcon: false,
                                      borderedBtnTitle: e.status == "Complete"
                                          ? kViewOrder.tr()
                                          : e.status == "Inreview" ||
                                                  e.status == "Active"
                                              ? kCloseRfq.tr()
                                              : null,
                                      filledBtnTitle: e.status != "Inreview"
                                          ? e.quoteCount! > 0
                                              ? "${kView.tr()} ${e.quoteCount} ${kQuote.tr()}"
                                              : null
                                          : null,
                                      onBorderedBtnTapped: () {
                                        if (e.status == "Inreview" ||
                                            e.status == "Active") {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return ConfirmationSheet(
                                                    explanation:
                                                        kThisWillRemoveRfq.tr(),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            3,
                                                    onConfirmTapped: () {
                                                      myRfqBloc.add(UpdateMyRfq(
                                                          status: e.status ==
                                                                      "Inreview" ||
                                                                  e.status ==
                                                                      "Active"
                                                              ? "Closed"
                                                              : "Active",
                                                          id: e.id!));
                                                      context.pop();
                                                    },
                                                    filledBtnColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    filledBtnText:
                                                        kYesContinue.tr(),
                                                    outlinedBtnText:
                                                        kCancel.tr(),
                                                    title: kAreYouSureCloseRfq
                                                        .tr());
                                              });
                                        }
                                        if (e.status == "Complete") {
                                          context.pushNamed(myOrderScreenName);
                                        }
                                      },
                                      onFilledBtnTapped: () {
                                        if (e.status != "Inreview" &&
                                            e.quoteCount! > 0) {
                                          context.pushNamed(
                                              myEnqiryDetailPageName,
                                              extra: e,
                                              queryParameters: {
                                                'initialTab': '1'
                                              });
                                        }
                                      },
                                      onDetailTapped: () {
                                        e.status == "Inreview"
                                            ? context.pushNamed(
                                                enquiryDetailPageName,
                                                extra: e,
                                                queryParameters: {
                                                    'title': kEnquiryDetail.tr()
                                                  })
                                            : context.pushNamed(
                                                myEnqiryDetailPageName,
                                                extra: e);
                                      }))
                                  .toList(),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 250),
                                  OutlinedButtonWidget(
                                      title: 'Create Enquiry',
                                      onPressed: () {
                                        context
                                            .read<HomeTabCubit>()
                                            .changeTab(0);
                                      })
                                ],
                              ),
                            );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  SizedBox(
                    height: 100,
                    child: BlocBuilder<MyRfqBloc, MyRfqState>(
                      builder: (context, state) {
                        if (state is MyRfqLoadMore) {
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
        ),
      ],
    );
  }
}
