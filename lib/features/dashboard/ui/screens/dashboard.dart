import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/chat/ui/screens/chat_home_page.dart';
import 'package:metaltrade/features/dashboard/ui/widgets/destinations.dart';
import 'package:metaltrade/features/dashboard/ui/widgets/kyc_blocker_widget.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_home_page.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/profile/ui/screens/profile_screen.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/screens/rfq_home_page.dart';
import '../../../my_home/ui/controllers/enquiry_file_pick_cubit/enquiry_file_pick_cubit.dart';
import '../../../news/ui/screens/news_page.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../controllers/bottom_bar_controller_cubit.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSheetOpen = false;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              if (state.profileEntity.company == null) {
                if (!isSheetOpen) {
                  isSheetOpen = true;
                  showModalBottomSheet(
                      isDismissible: false,
                      useRootNavigator: true,
                      isScrollControlled: false,
                      enableDrag: false,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      context: context,
                      builder: (context) {
                        return const KycBlocker();
                      });
                }
              } else {
                if (isSheetOpen) {
                  context.read<ProfileBloc>().add(EmitKycDoneEvent());
                  context
                      .read<MyRfqBloc>()
                      .add(GetMyRfqList(isLoadMore: false, page: 0));
                  context.read<MyQuoteBloc>().add(GetQuoteList(
                      status: const [], isLoadMore: false, page: 0));
                  context
                      .read<RfqBuyerEnquiryBloc>()
                      .add(GetRfqBuyerPageEnquiryEvent(
                        page: 0,
                        intent: UserIntent.Buy,
                      ));
                  context.read<RfqSellerEnquiryBloc>().add(
                      GetRfqSellerEnquiryEvent(
                          intent: UserIntent.Sell, page: 0));
                  context
                      .read<NewsBloc>()
                      .add(GetAllNewsEvent(page: 0, filters: 'rb'));
                  context.read<ChatHomeBloc>().add(GetChatHomeList(page: 0));
                }
              }
            } else if (state is KycCompletedState) {
              context.pop();
            }
          },
          builder: (context, state) {
            return getPages();
          },
        ),
        bottomNavigationBar: getBottomNavBar());
  }

  Widget getPages() {
    const List<Widget> pageList = [
      MyHomePage(),
      RfqHomePage(),
      NewsPage(),
      ChatHomePage(),
      ProfileScreen()
    ];
    return BlocBuilder<BottomNavControllerCubit, int>(
        builder: (context, state) {
      return IndexedStack(
        index: state,
        children: pageList,
      );
    });
  }

  Widget getBottomNavBar() {
    return BlocBuilder<BottomNavControllerCubit, int>(
      builder: (context, state) {
        return NavigationBar(
          destinations: destinations,
          selectedIndex: state,
          indicatorColor:
              Theme.of(context).colorScheme.inversePrimary.withOpacity(0.50),
          onDestinationSelected: (value) {
            context.read<EnquiryFilePickCubit>().emitInitialState();
            context.read<BottomNavControllerCubit>().changeIndex(value);
          },
        );
      },
    );
  }
}
