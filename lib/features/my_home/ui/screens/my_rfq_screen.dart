import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';
import '../../../../core/routes/routes.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../../profile/ui/widgets/kyc_dialog.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.profileEntity.company != null) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(height: appFormFieldGap),
                  const FilterChipList(),
                  BlocBuilder<MyRfqBloc, MyRfqState>(builder: (context, state) {
                    if (state is MyRfqInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MyRfqFetchedState ||
                        state is MyRfqLoadMore) {
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: myRfqBloc.myRfqList
                            .map((e) => HomePageCard(
                                content: e,
                                itemList: e.item,
                                enquiryType: e.enquiryType,
                                country: e.enquiryCompany!.country!.name,
                                uuid: e.uuid,
                                borderedBtnTitle: e.status == "Complete"
                                    ? kViewOrder
                                    : kCloseRfq,
                                filledBtnTitle: e.status != "Inreview"
                                    ? e.quoteCount! > 0
                                        ? "$kView ${e.quoteCount} $kQuote"
                                        : null
                                    : null,
                                onBorderedBtnTapped: () {
                                  myRfqBloc.add(UpdateMyRfq(
                                      status: e.status != "Inreview"
                                          ? "Complete"
                                          : "Active",
                                      id: e.id!));
                                },
                                onFilledBtnTapped: () {},
                                onDetailTapped: () {
                                  e.status == "Inreview"
                                      ? context.pushNamed(enquiryDetailPageName,
                                          extra: e)
                                      : context.pushNamed(
                                          myEnqiryDetailPageName,
                                          extra: e);
                                }))
                            .toList(),
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
